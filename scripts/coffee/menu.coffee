BaseState = require('./basestate')
Donkey = require('./donkey')


class Menu extends BaseState

  create: ->
    super

    # Show Top score
    if not @game.highscore
      @game.highscore = 0
    highscoreLabel = @game.add.text(0, @game.world.height-74, 'Highscore: '+@game.highscore, {font: '32px VT323', fill: '#fff'})
    highscoreLabel.x = @game.world.width - (highscoreLabel._width + 10)

    flappyLabel = @game.add.text(0, 42, 'FLAPPY', {font: '96px VT323', fill: '#fff'})
    flappyLabel.x = @game.world.width/2 - flappyLabel._width/2
    donkLabel = @game.add.text(0, 118, 'DONK', {font: '96px VT323', fill: '#fff'})
    donkLabel.x = @game.world.width/2 - donkLabel._width/2
    descLabel = @game.add.text(0, 224, 'A realistic barrel jumping simulator', {font: '16px VT323', fill: '#fff'})
    descLabel.x = @game.world.width/2 - descLabel._width/2
    versionLabel = @game.add.text(0, 248, 'Patch v0.0.0.0.0.23.0.1', {font: '16px VT323', fill: '#fff'})
    versionLabel.x = @game.world.width/2 - versionLabel._width/2
    startLabel = @game.add.text(10, @game.world.height-74, 'Start: SPACE', {font: '32px VT323', fill: '#fff'})

    @createIdle()
    @createDonkSelection()

  createDonkSelection: ->
    console.log('Donk selection!')
    #TODO: create donk selection
    #TODO: add platofrm and animate off it for the game

  update: ->
    super
    @player.idle()

module.exports = Menu
