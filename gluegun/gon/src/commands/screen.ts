import { GluegunToolbox } from 'gluegun'

// enum Patterns {
// NAV_IMPORTS_SCREENS = '} from "../screens',
// NAV_IMPORTS_NAVIGATORS = 'import[\\s\\S]*from\\s+"react-navigation";?',
// ROOT_NAV_ROUTES = 'export const PrimaryNavigator.+[\\s\\S]\\s+{',
// NAV_ROUTES = 'export const [a-zA-Z0-9]+ = create[a-zA-Z]+[(][{]'
// }

module.exports = {
  name: 'screen',
  alias: ['s'],
  description: 'Generates screen and add it to default stacks',
  run: async (toolbox: GluegunToolbox) => {
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
      print.info(`ignite generate screen <name>\n`)
      return
    }

    const name = parameters.first
    const screenName = name.endsWith('-screen')
      ? kebabCase(name)
      : `${kebabCase(name)}-screen`
    // prettier-ignore
    if (name.endsWith('-screen')) {
    print.info(`Note: For future reference, the \`-screen\` suffix is automatically added for you.`)
    print.info(`You're welcome to add it manually, but we wanted you to know you don't have to. :)`)
  }

    // get permutations of the given model name
    const pascalName = pascalCase(screenName)
    const camelName = camelCase(screenName)

    const props = { name: screenName, pascalName, camelName }

    await generate({
      template: `screen.tsx.ejs`,
      target: `app/screens/${screenName}/${pascalName}.tsx`,
      props: props
    })

    print.info(
      'Created file at ' + `app/screens/${screenName}/${pascalName}.tsx`
    )

    // make the templates
    // patch the barrel export file
    const barrelExportPath = `${process.cwd()}/app/screens/index.ts`
    const exportToAdd = `export * from "./${screenName}/${pascalName}"\n`

    if (!filesystem.exists(barrelExportPath)) {
      const msg =
        `No '${barrelExportPath}' file found. Can't export screen.` +
        `Export your new screen manually.`
      print.warning(msg)
      process.exit(1)
    }

    await patching.append(barrelExportPath, exportToAdd)
    // // if using `react-navigation` go the extra step
    // // and insert the screen into the nav router
    // let rootNavigator = parameters.second
    // ? parameters.second
    // : 'primary-navigator'
    // rootNavigator = rootNavigator.endsWith('-navigator')
    // ? rootNavigator
    // : `${rootNavigator}-navigator`

    // const appNavFilePath = `${process.cwd()}/app/navigation/${rootNavigator}.ts`
    // const importToAdd = `  ${pascalName},\n`
    // const routeToAdd = `\n    ${camelName}: { screen: ${pascalName} },`

    // if (!filesystem.exists(appNavFilePath)) {
    // const msg =
    // `No '${appNavFilePath}' file found.  Can't insert screen.` +
    // `Add your new screen manually to your navigation.`
    // print.error(msg)
    // process.exit(1)
    // }

    // // insert screen import
    // await patching.patch(appNavFilePath, {
    // before: new RegExp(Patterns.NAV_IMPORTS_SCREENS),
    // insert: importToAdd
    // })

    // const ROOT_NAV_ROUTES = `export const ${pascalCase(
    // rootNavigator
    // )}.+[\\s\\S]\\s+{`
    // print.info('root nav ' + ROOT_NAV_ROUTES)
    // // insert screen route
    // await patching.patch(appNavFilePath, {
    // after: new RegExp(ROOT_NAV_ROUTES),
    // insert: routeToAdd
    // })

    // print.info(`imported nav to ${rootNavigator}`)
  }
}
