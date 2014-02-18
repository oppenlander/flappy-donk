BaseState = require './basestate'

class Credits extends BaseState

  create: ->
    super

    creatorLabel = @game.add.text(0, 48, 'Made by: Andrew O.', {font: '48px VT323', fill: '#fff'})
    creatorLabel.x = @gw/2 - creatorLabel._width/2
    creatorSubLabel = @game.add.text(0, 88, 'Twitter: usagimaru57', {font: '32px VT323', fill: '#fff'})
    creatorSubLabel.x = @gw/2 - creatorSubLabel._width/2
    creatorSubSubLabel = @game.add.text(0, 118, 'GitHub: oppenlander', {font: '32px VT323', fill: '#fff'})
    creatorSubSubLabel.x = @gw/2 - creatorSubSubLabel._width/2

    musicLabel = @game.add.text(0, @gh/2+70, 'Music: Rocco Wouters', {font: '32px VT323', fill: '#fff'})
    musicLabel.x = @gw/2 - musicLabel._width/2

    explosionLabel = @game.add.text(0, @gh/2+110, 'SFX: SoundBible.com', {font: '32px VT323', fill: '#fff'})
    explosionLabel.x = @gw/2 - explosionLabel._width/2

    startLabel = @game.add.text(10, @gh-58, 'Start: SPACE', {font: '16px VT323', fill: '#fff'})

    menuLabel = @game.add.text(0, @gh-58, 'Menu/Character Select: M', {font: '16px VT323', fill: '#fff'})
    menuLabel.x = @gw - (menuLabel._width + 10)

    @createIdle()

  update: ->
    super
    @player.idle()

module.exports = Credits
