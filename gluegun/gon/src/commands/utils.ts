import { GluegunToolbox } from 'gluegun'

export const description = 'Generates utils'
export const alias = 'u'
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
  const { pascalCase, isBlank } = strings

  // validation
  if (isBlank(parameters.first)) {
    print.info('A name is required.')
    print.info(`ignite generate component <name>\n`)
    return
  }

  const name = parameters.first
  const pascalName = pascalCase(name)

  const props = { name, pascalName }
  const jobs = []

  jobs.push({
    template: `utils.tsx.ejs`,
    target: `app/utils/${name}/${name}.tsx`
  })

  jobs.push({
    template: `ultis.index.ts.ejs`,
    target: `app/utils/${name}/index.ts`
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
  const barrelExportPath = `${process.cwd()}/app/utils/index.ts`
  const exportToAdd = `export * from "./${name}/${name}"\n`
  print.info('Exported to utils index file!')

  if (!filesystem.exists(barrelExportPath)) {
    const msg =
      `No '${barrelExportPath}' file found. Can't export component.` +
      `Export your new component manually.`
    print.warning(msg)
    process.exit(1)
  }
  await patching.append(barrelExportPath, exportToAdd)
}
