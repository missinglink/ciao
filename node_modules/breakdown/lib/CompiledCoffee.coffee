
Coffeescript = require 'coffee-script'
File = require './File'

class CompiledCoffee extends File

  read: () =>

    super() and @source = Coffeescript.compile @source

module.exports = CompiledCoffee