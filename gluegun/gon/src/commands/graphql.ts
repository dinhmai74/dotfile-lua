import { GluegunToolbox } from 'gluegun'

export const description =
  'Generates a graphql node file: Resolver, entity, graphql-types.'

export const name = 'graphql'
export const alias = 'ga'

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
  const { pascalCase, isBlank, camelCase, kebabCase } = strings

  // validation
  if (isBlank(parameters.first)) {
    print.info('A name is required.')
    print.info(`ignite generate component <name>\n`)
    return
  }

  const name = parameters.first
  const pascalName = pascalCase(name)
  const kebabName = kebabCase(name)
  const camelCaseName = camelCase(name)
  const props = { name, pascalName, camelCaseName }

  const jobs = [
    {
      template: 'entity.ts.ejs',
      target: `./src/entity/${pascalName}.ts`,
      exportToAdd: `export * from "./${pascalName}"\n`,
      barrel: './src/entity/index.ts'
    },
    {
      template: 'graphql-input.ts.ejs',
      target: `./src/graphql-types/${kebabName}/${pascalName}Input.ts`,
      exportToAdd: `export * from "./${kebabName}/${pascalName}Input"\n`,
      barrel: './src/graphql-types/index.ts'
    },
    {
      template: 'graphql-response.ts.ejs',
      target: `./src/graphql-types/${kebabName}/${pascalName}Response.ts`,
      exportToAdd: `export * from "./${kebabName}/${pascalName}Response"\n`,
      barrel: './src/graphql-types/index.ts'
    },
    {
      template: 'graphql-resolver.ts.ejs',
      target: `./src/resolvers/${kebabName}/${pascalName}.resolver.ts`
    }
  ]

  for (let i = 0; i < jobs.length; i++) {
    let e = jobs[i]
    const { barrel, exportToAdd } = e
    await generate({
      template: e.template,
      target: e.target,
      props: props
    })

    if (!filesystem.exists(barrel)) {
      const msg =
        `No '${barrel}' file found. Can't export component.` +
        `Export your new component manually.`
      print.warning(msg)
    } else await patching.append(barrel, exportToAdd)

    print.info('Created file ' + e.target)
  }

  // patch the barrel export file
  // const barrelExportPath = `${process.cwd()}/app/components/index.ts`
  // const exportToAdd = `export * from "./${name}/${name}"\n`

  // if (!filesystem.exists(barrelExportPath)) {
  // const msg =
  // `No '${barrelExportPath}' file found. Can't export component.` +
  // `Export your new component manually.`
  // print.warning(msg)
  // process.exit(1)
  // }
  // await patching.append(barrelExportPath, exportToAdd)

  // wire up example
  // await patching.prepend(
  //   './storybook/storybook-registry.ts',
  //   `require("../app/components/${name}/${name}.story")\n`
  // )
}
