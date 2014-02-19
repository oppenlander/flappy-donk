Donkey = require('./donkey')

class BaseState

  create: ->
    @gw = @game.world.width
    @gh = @game.world.height
    @gerterSize = 32

    if not @game.babyMode?
      @game.babyMode = false

    # Init background image
    @game.add.sprite(0, 0, 'bg')

    # Init background music
    if not @game.backgroundMusic?
      musicName = if not @game.babyMode then 'braadslee' else 'babysong'
      @game.backgroundMusic = @game.add.audio(musicName)
      @game.backgroundMusic.play('', 0, 1, true)
      if not @game.soundOn?
        @game.soundOn
      if not @game.soundOn
        @game.backgroundMusic.pause()

    # Init sound on
    if not @game.soundOn?
      @game.soundOn = true

    # Init sound control
    @soundToggle = @game.add.button(@gw-38, 42, 'mute', @toggleSound, @)
    if not @game.soundOn
      @soundToggle.frame = 1

    # Init user input
    if not @game.isMobile
      @game.input.keyboard.callbackContext = @
      @game.input.keyboard.onDownCallback = @onKeyDown
      @game.input.keyboard.onUpCallback = @onKeyUp
      @game.input.keyboard.addKeyCapture(Phaser.Keyboard.SPACEBAR)
      @game.input.keyboard.addKeyCapture(Phaser.Keyboard.C)
      @game.input.keyboard.addKeyCapture(Phaser.Keyboard.M)
      @game.input.keyboard.addKeyCapture(Phaser.Keyboard.P)
      @game.input.keyboard.addKeyCapture(Phaser.Keyboard.LEFT)
      @game.input.keyboard.addKeyCapture(Phaser.Keyboard.Right)
    else
      @game.input.touch.callbackContext = @
      @game.input.touch.touchStartCallback = @onTouchStart
      @game.input.touch.touchEndCallback = @onTouchEnd
      @game.input.touch.start()

    # Init Ceiling/Floor tiles
    @gerters = @game.add.group()
    numEdgeTiles = Math.ceil(@gw / @gerterSize)
    @gertersArray = []
    for i in [0..numEdgeTiles]
      floorTile = @gerters.create(i * @gerterSize, @gh - @gerterSize, 'gerter')
      floorTile.body.immovable = true
      @gertersArray.push(floorTile)

      ceilingTile = @gerters.create(i * @gerterSize, 0, 'gerter')
      ceilingTile.body.immovable = true
      @gertersArray.push(ceilingTile)

  createIdle: ->
    # Create Donk
    if not @game.donkSelection?
      @game.donkSelection = Donkey
    @player = new @game.donkSelection(@game)

    # Create ledge gerters
    donkOffset = if @game.babyMode then 20 else 40
    for i in [0..(Math.ceil(@game.world.width/(3*32)-1))]
      @game.add.sprite(i*32, @player.sprite.y + donkOffset, 'gerter')
    @player.sprite.bringToTop()

  toggleBabymode: ->
    @game.babyMode = if @game.babyMode then false else true
    @game.backgroundMusic.stop()
    @game.backgroundMusic = null
    @game.state.start('Menu')

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
    else if event.keyCode == Phaser.Keyboard.C
      @game.state.start('Credits')
    else if event.keyCode == Phaser.Keyboard.P
      @toggleSound()
    else if event.keyCode == Phaser.Keyboard.B
      @toggleBabymode()

  onKeyUp: (event) ->

  onTouchStart: (event) ->
    @game.state.start('Play')

  onTouchEnd: (event) ->

  update: ->
    if not @game.soundOn
      @game.backgroundMusic.pause()

module.exports = BaseState
