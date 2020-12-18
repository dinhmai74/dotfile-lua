import { GluegunToolbox } from 'gluegun'
const fs = require('fs')

export const description = 'auto export all file to index dir'

export const name = 'autoexport'
export const alias = 'ae'

export const run = async function(toolbox: GluegunToolbox) {
  let type = ''
  fs.readdir('.', (err, files) => {
    files.forEach(file => {
      const finalName = file.toString().replace(/\.(svg|js|jsx|ts|tsx)$/g, '')
      type += `export * from './${finalName}'\n`
    })
    fs.appendFile('index.js', type, function(err) {
      if (err) throw err
      console.log('Saved!')
    })
  })
}
