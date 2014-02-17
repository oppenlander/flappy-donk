Boot = require './boot'
Load = require './load'
Menu = require './menu'
Play = require './play'
Dead = require './dead'
Credits = require './credits'

game = new Phaser.Game 400, 600, Phaser.AUTO, ''

game.state.add 'Boot', Boot
game.state.add 'Load', Load
game.state.add 'Menu', Menu
game.state.add 'Play', Play
game.state.add 'Dead', Dead
game.state.add 'Credits', Credits

game.state.start 'Boot'

module.exports = game
