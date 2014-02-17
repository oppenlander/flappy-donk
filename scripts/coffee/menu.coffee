BaseState = require './basestate'

class Menu extends BaseState

  create: ->
    @game.add.sprite(0, 0, 'bg')

    if not @game.backgroundMusic
      @game.backgroundMusic = @game.add.audio('braadslee')
      @game.backgroundMusic.play('', 0, 1, true)

    @soundToggle = @game.add.button(@game.world.width-38, 42, 'mute', @toggleSound, @)
    if not @game.soundOn?
      @game.soundOn = true
    else if not @game.soundOn
      @soundToggle.frame = 1

    # Show Top score
    if not @game.highscore
      @game.highscore = 0
    highscoreLabel = @game.add.text(0, @game.world.height-74, 'Highscore: '+@game.highscore, {font: '32px VT323', fill: '#fff'})
    highscoreLabel.x = @game.world.width - (highscoreLabel._width + 10)

    # Selection pane of a couple Donkeys
    @createDonkSelection()

    flappyLabel = @game.add.text(0, 42, 'FLAPPY', {font: '96px VT323', fill: '#fff'})
    flappyLabel.x = @game.world.width/2 - flappyLabel._width/2
    donkLabel = @game.add.text(0, 118, 'DONK', {font: '96px VT323', fill: '#fff'})
    donkLabel.x = @game.world.width/2 - donkLabel._width/2
    descLabel = @game.add.text(0, 224, 'A realistic barrel jumping simulator', {font: '16px VT323', fill: '#fff'})
    descLabel.x = @game.world.width/2 - descLabel._width/2

    startLabel = @game.add.text(10, @game.world.height-74, 'Start: SPACE', {font: '32px VT323', fill: '#fff'})

    creditsLabel = @game.add.text(10, 32, 'Credits: C', {font: '16px VT323', fill: '#fff'})

    for i in [0..(Math.ceil @game.world.width/32)]
      @game.add.sprite(i*32, @game.world.height-32, 'gerter')
      @game.add.sprite(i*32, 0, 'gerter')

    @gameStarting = false

    @game.input.keyboard.callbackContext = @
    @game.input.keyboard.onDownCallback = @onKeyDown
    @game.input.keyboard.onUpCallback = @onKeyUp

    @elapsedTime = 0

  createDonkSelection: ->
    console.log('Create the Donk selection')
    @player = @game.add.sprite(@game.world.width/4, @game.world.height/2, 'donkey')
    #TODO: create donk selection
    #TODO: add platofrm and animate off it for the game

  toggleSound: ->
    if @game.soundOn
      @game.soundOn = false
      @soundToggle.frame = 1
      @game.backgroundMusic.pause()
    else
      @game.soundOn = true
      @soundToggle.frame = 0
      @game.backgroundMusic.resume()

  onKeyDown: (event) ->
    if event.keyCode == Phaser.Keyboard.SPACEBAR
      @game.state.start('Play')
    else if event.keyCode == Phaser.Keyboard.C
      console.log('TODO: make credits page')
      #game.state.start('Credits')

  onKeyUp: (event) ->

  update: ->
    @elapsedTime += @game.time.elapsed
    if @elapsedTime > 1000
      # Move frame back and forth
      @player.frame = ++@player.frame % 2
      @elapsedTime = 0

    if not @game.soundOn
      @game.backgroundMusic.pause()

module.exports = Menu
