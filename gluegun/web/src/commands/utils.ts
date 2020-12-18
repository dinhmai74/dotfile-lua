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
  await generate({
    template: `utils.tsx.ejs`,
    target: `src/utils/${name}/${name}.tsx`,
    props: props
  })

  await generate({
    template: `ultis.index.ts.ejs`,
    target: `src/utils/${name}/index.ts`,
    props: props
  })

  // patch the barrel export file
  const barrelExportPath = `${process.cwd()}/src/utils/index.ts`
  const exportToAdd = `export * from "./${name}/${name}"\n`

  if (!filesystem.exists(barrelExportPath)) {
    const msg =
      `No '${barrelExportPath}' file found. Can't export component.` +
      `Export your new component manually.`
    print.warning(msg)
    process.exit(1)
  }
  await patching.append(barrelExportPath, exportToAdd)
}
