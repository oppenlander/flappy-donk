class Dead

  create: ->
    @game.add.sprite(0, 0, 'bg')

    @soundToggle = @game.add.button(@game.world.width-38, 42, 'mute', @toggleSound, @)
    if not @game.soundOn
      @soundToggle.frame = 1

    if @game.newRecord
      responseLabel1 = @game.add.text(0, 42, 'Congrats!', {font: '96px VT323', fill: '#fff'})
      responseLabel2 = @game.add.text(0, 138, 'New Record', {font: '64px VT323', fill: '#fff'})
    else
      responseLabel1 = @game.add.text(0, 42, 'Failure!', {font: '96px VT323', fill: '#fff'})
      responseLabel2 = @game.add.text(0, 138, 'What the donk?', {font: '64px VT323', fill: '#fff'})
    responseLabel1.x = @game.world.width/2 - responseLabel1._width/2
    responseLabel2.x = @game.world.width/2 - responseLabel2._width/2

    # Create labels
    highscoreLabel = @game.add.text(0, @game.world.height-190, 'Highscore: '+@game.highscore, {font: '64px VT323', fill: '#fff'})
    highscoreLabel.x = @game.world.width/2 - highscoreLabel._width/2

    scoreLabel = @game.add.text(0, @game.world.height-116, 'Score: '+@game.score, {font: '48px VT323', fill: '#fff'})
    scoreLabel.x = @game.world.width/2 - scoreLabel._width/2

    restartLabel = @game.add.text(10, @game.world.height-58, 'Restart: SPACE', {font: '16px VT323', fill: '#fff'})

    menuLabel = @game.add.text(0, @game.world.height-58, 'Menu/Character Select: M', {font: '16px VT323', fill: '#fff'})
    menuLabel.x = @game.world.width - (menuLabel._width + 10)

    creditsLabel = @game.add.text(0, @game.world.height-78, 'Credits: C', {font: '16px VT323', fill: '#fff'})
    creditsLabel.x = @game.world.width - (creditsLabel._width + 10)

    # Create edges
    for i in [0..(Math.ceil @game.world.width/32)]
      @game.add.sprite(i*32, @game.world.height-32, 'gerter')
      @game.add.sprite(i*32, 0, 'gerter')

    if not @game.isMobile
      @game.input.keyboard.callbackContext = @
      @game.input.keyboard.onDownCallback = @onKeyDown
      @game.input.keyboard.onUpCallback = @onKeyUp
    else
      @game.input.touch.callbackContext = @
      @game.input.touch.touchStartCallback = @onTouchStart
      @game.input.touch.touchEndCallback = @onTouchEnd
      @game.input.touch.start()

    @player = @game.add.sprite(@game.world.width/4, @game.world.height/2, 'donkey')

    # Create ledge gerters
    for i in [0..(Math.ceil(@game.world.width/(3*32)-1))]
      @game.add.sprite(i*32, @player.y + 40, 'gerter')
    @player.bringToTop()

    @elapsedTime = 0

  onKeyDown: (event) ->
    if event.keyCode == Phaser.Keyboard.SPACEBAR
      @game.state.start('Play')
    else if event.keyCode == Phaser.Keyboard.M
      @game.state.start('Menu')
    else if event.keyCode == Phaser.Keyboard.C
      @game.state.start('Credits')
    else if event.keyCode == Phaser.Keyboard.P
      @toggleSound()

  onKeyUp: (event) ->

  onTouchStart: (event) ->
    @game.state.start('Play')

  onTouchEnd: (event) ->

  toggleSound: ->
    if @game.soundOn
      @game.soundOn = false
      @soundToggle.frame = 1
      @game.backgroundMusic.pause()
    else
      @game.soundOn = true
      @soundToggle.frame = 0
      @game.backgroundMusic.resume()

  update: ->
    @elapsedTime += @game.time.elapsed
    if @elapsedTime > 1000
      # Move frame back and forth
      @player.frame = ++@player.frame % 2
      @elapsedTime = 0

module.exports = Dead
