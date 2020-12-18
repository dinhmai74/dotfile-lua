import { GluegunToolbox } from 'gluegun'

export const description = 'Generates zustands'
export const alias = 'z'
export const run = async function(toolbox: GluegunToolbox) {
  // grab some features
  const {
    parameters,
    template: { generate },
    print,
    strings,
    filesystem,
    patching
  } = toolbox
  const { pascalCase, isBlank, camelCase } = strings

  // validation
  if (isBlank(parameters.first)) {
    print.info('A name is required.')
    print.info(`ignite generate component <name>\n`)
    return
  }

  const name = parameters.first
  const storeName = name.endsWith('-store') ? name : `${name}-store`
  // prettier-ignore
  if (name.endsWith('-store')) {
    print.info(`Note: For future reference, the \`-store\` suffix is automatically added for you.`)
    print.info(`You're welcome to add it manually, but we wanted you to know you don't have to. :)`)
  }

  const pascalName = pascalCase(storeName)
  const camelName = camelCase(storeName)
  const jobs = []

  const props = { name: storeName, pascalName, camelName }
  jobs.push({
    template: `zustand.tsx.ejs`,
    target: `src/zustands/${storeName}/${pascalName}.tsx`
  })
  for (let i = 0; i < jobs.length; i++) {
    let e = jobs[i]
    await generate({
      template: e.template,
      target: e.target,
      props: props
    })

    print.info('Created file ' + e.target)
  }

  // patch the barrel export file
  const barrelExportPath = `${process.cwd()}/src/zustands/index.ts`
  const exportToAdd = `export * from "./${storeName}/${pascalName}"\n`

  if (!filesystem.exists(barrelExportPath)) {
    const msg =
      `No '${barrelExportPath}' file found. Can't export component.` +
      `Export your new component manually.`
    print.warning(msg)
    process.exit(1)
  }
  await patching.append(barrelExportPath, exportToAdd)
}
