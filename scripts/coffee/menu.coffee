BaseState = require('./basestate')
Donkey = require('./donkey')
Squier = require('./squier')
King = require('./king')
Woodfighter = require('./woodfighter')


class Menu extends BaseState

  create: ->
    super

    # Show Top score
    if not @game.highscore
      @game.highscore = 0
    highscoreLabel = @game.add.text(0, @gh-74, 'Highscore: '+@game.highscore, {font: '32px VT323', fill: '#fff'})
    highscoreLabel.x = @gw - (highscoreLabel._width + 10)

    flappyLabel = @game.add.text(0, 42, 'FLAPPY', {font: '96px VT323', fill: '#fff'})
    flappyLabel.x = @gw/2 - flappyLabel._width/2
    donkLabel = @game.add.text(0, 118, 'DONK', {font: '96px VT323', fill: '#fff'})
    donkLabel.x = @gw/2 - donkLabel._width/2
    descLabel = @game.add.text(0, 224, 'A realistic barrel jumping simulator', {font: '16px VT323', fill: '#fff'})
    descLabel.x = @gw/2 - descLabel._width/2
    versionLabel = @game.add.text(0, 248, 'Patch v0.0.0.0.0.23.0.2', {font: '16px VT323', fill: '#fff'})
    versionLabel.x = @gw/2 - versionLabel._width/2
    startLabel = @game.add.text(10, @gh-74, 'Start: SPACE', {font: '32px VT323', fill: '#fff'})

    @createIdle()
    @createDonkSelection()

  createDonkSelection: ->
    console.log('Donk selection!')
    @donks = [
      Donkey
      Squier
      King
      Woodfighter
    ]
    #TODO: create donk selection
    #TODO: add platofrm and animate off it for the game

  getDonkIndex: () ->
    if @game.donkSelection == Donkey
      0
    else if @game.donkSelection == Squier
      1
    else if @game.donkSelection == King
      2
    else if @game.donkSelection == Woodfighter
      3
    else
      0

  selectDonk: (donk) ->
    @game.donkSelection = donk
    @player.destroy()
    @player = new donk(@game)

  onKeyDown: (event) ->
    if event.keyCode == Phaser.Keyboard.LEFT
      @selectDonk(@donks[(@getDonkIndex() + 1) % 4])
    else if event.keyCode == Phaser.Keyboard.RIGHT
      @selectDonk(@donks[(@getDonkIndex() + 3) % 4])
    else
      super

  update: ->
    super
    @player.idle()

module.exports = Menu
