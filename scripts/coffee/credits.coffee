BaseState = require './basestate'

class Credits extends BaseState

  create: ->
    @game.add.sprite(0, 0, 'bg')

    @soundToggle = @game.add.button(@game.world.width-38, 42, 'mute', @toggleSound, @)
    if not @game.soundOn?
      @game.soundOn = true
    else if not @game.soundOn
      @soundToggle.frame = 1

    for i in [0..(Math.ceil @game.world.width/32)]
      @game.add.sprite(i*32, @game.world.height-32, 'gerter')
      @game.add.sprite(i*32, 0, 'gerter')

    @player = new @game.donkSelection(@game)

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

    # Create ledge gerters
    for i in [0..(Math.ceil(@game.world.width/(3*32)-1))]
      @game.add.sprite(i*32, @player.sprite.y + 40, 'gerter')
    @player.sprite.bringToTop()

    if not @game.isMobile
      @game.input.keyboard.callbackContext = @
      @game.input.keyboard.onDownCallback = @onKeyDown
      @game.input.keyboard.onUpCallback = @onKeyUp
    else
      @game.input.touch.callbackContext = @
      @game.input.touch.touchStartCallback = @onTouchStart
      @game.input.touch.touchEndCallback = @onTouchEnd
      @game.input.touch.start()

    @elapsedTime = 0


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
    else if event.keyCode == Phaser.Keyboard.M
      @game.state.start('Menu')
    else if event.keyCode == Phaser.Keyboard.P
      @toggleSound()

  onKeyUp: (event) ->

  onTouchStart: (event) ->
    @game.state.start('Play')

  onTouchEnd: (event) ->

  update: ->
    @player.idle()

module.exports = Credits
