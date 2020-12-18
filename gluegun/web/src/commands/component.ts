import { GluegunToolbox } from 'gluegun'

export const description = 'Generates a component, supporting files, .'

export const name = 'component'
export const alias = 'c'

export const run = async function(toolbox: GluegunToolbox) {
  // grab some features
  const {
    parameters,
    template: { generate },
    print,
    strings,
    filesystem,
    patching,
    prompt
  } = toolbox
  const { pascalCase, isBlank, camelCase } = strings

  // validation
  if (isBlank(parameters.first)) {
    print.info('A name is required.')
    print.info(`ignite generate component <name>\n`)
    return
  }

  let componentType
  if (
    !parameters.options['function-component'] &&
    !parameters.options['stateless-function']
  ) {
    const componentTypes = [
      {
        name: 'functionComponent',
        message: 'React.FunctionComponent, aka "hooks component"'
      },
      {
        name: 'statelessFunction',
        message: 'Stateless function, aka the "classic" ignite-bowser component'
      },
      {
        name: 'classComponent',
        message: 'Classic class component'
      }
    ]

    const { component } = await prompt.ask([
      {
        name: 'component',
        message: 'Which type of component do you want to generate?',
        type: 'select',
        choices: componentTypes
      }
    ])
    componentType = component
  }

  const name = parameters.first
  const pascalName = pascalCase(name)
  const camelCaseName = camelCase(name)
  const props = { name, pascalName, camelCaseName }

  const jobs = [
    // {
    // template: 'component.story.tsx.ejs',
    // target: `src/stories/${name}.stories.js`
    // }
  ]

  if (
    componentType === 'functionComponent' ||
    parameters.options['function-component']
  ) {
    jobs.push({
      template: 'function-component.tsx.ejs',
      target: `src/components/${name}/${pascalName}.tsx`
    })
  } else if (
    componentType === 'statelessFunction' ||
    parameters.options['stateless-function']
  ) {
    jobs.push({
      template: 'component.tsx.ejs',
      target: `src/components/${name}/${pascalName}.tsx`
    })
  } else {
    jobs.push({
      template: 'class-component.tsx.ejs',
      target: `src/components/${name}/${pascalName}.tsx`
    })
  }

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
  const barrelExportPath = `${process.cwd()}/src/components/index.ts`
  const exportToAdd = `export * from "./${name}/${pascalName}"\n`

  if (!filesystem.exists(barrelExportPath)) {
    const msg =
      `No '${barrelExportPath}' file found. Can't export component.` +
      `Export your new component manually.`
    print.warning(msg)
    process.exit(1)
  }
  await patching.append(barrelExportPath, exportToAdd)

  // wire up example
  // await patching.prepend(
  //   './storybook/storybook-registry.ts',
  //   `require("../src/components/${name}/${name}.story")\n`
  // )
}
