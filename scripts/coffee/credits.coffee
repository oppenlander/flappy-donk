BaseState = require './basestate'

class Credits extends BaseState

  create: ->
    super

    creatorLabel = @game.add.text(0, 48, 'Made by: Andrew O.', {font: '48px VT323', fill: '#fff'})
    creatorLabel.x = @game.world.width/2 - creatorLabel._width/2
    creatorSubLabel = @game.add.text(0, 88, 'Twitter: usagimaru57', {font: '32px VT323', fill: '#fff'})
    creatorSubLabel.x = @game.world.width/2 - creatorSubLabel._width/2
    creatorSubSubLabel = @game.add.text(0, 118, 'GitHub: oppenlander', {font: '32px VT323', fill: '#fff'})
    creatorSubSubLabel.x = @game.world.width/2 - creatorSubSubLabel._width/2

    musicLabel = @game.add.text(0, @game.world.height/2+70, 'Music: Rocco Wouters', {font: '32px VT323', fill: '#fff'})
    musicLabel.x = @game.world.width/2 - musicLabel._width/2

    explosionLabel = @game.add.text(0, @game.world.height/2+110, 'SFX: SoundBible.com', {font: '32px VT323', fill: '#fff'})
    explosionLabel.x = @game.world.width/2 - explosionLabel._width/2

    startLabel = @game.add.text(10, @game.world.height-58, 'Start: SPACE', {font: '16px VT323', fill: '#fff'})

    menuLabel = @game.add.text(0, @game.world.height-58, 'Menu/Character Select: M', {font: '16px VT323', fill: '#fff'})
    menuLabel.x = @game.world.width - (menuLabel._width + 10)

    @createIdle()

  update: ->
    super
    @player.idle()

module.exports = Credits
