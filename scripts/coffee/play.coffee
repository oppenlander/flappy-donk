class Play

  create: ->
    @game.add.sprite(0, 0, 'bg')

    # Gerter Tile size/speed constants
    @gerterSize = 32
    @gerterSpeed = 2

    # Reset score
    @game.score = 0
    @game.newRecord = false

    #TODO: set up scene to animate donk in from the left, then let user play

    @createTowers()
    @createEdges()
    @createPlayer()
    @createDashboard()

  createTowers: ->
    # Create Towers
    @towers = @game.add.group()

    topTower0 = @towers.create(@game.world.width, @gerterSize-10, 'gerter_tower_220_top')
    topTower0.towerIdx = 0
    topTower0.body.immovable = true
    botTower0 = @towers.create(@game.world.width, @game.world.height-242, 'gerter_tower_220')
    botTower0.body.immovable = true

    topTower1 = @towers.create(@game.world.width, @gerterSize-10, 'gerter_tower_220_top')
    topTower1.towerIdx = 1
    topTower1.body.immovable = true
    botTower1 = @towers.create(@game.world.width, @game.world.height-242, 'gerter_tower_220')
    botTower1.body.immovable = true

    topTower2 = @towers.create(@game.world.width, @gerterSize-10, 'gerter_tower_330_top')
    topTower2.towerIdx = 2
    topTower2.body.immovable = true
    botTower2 = @towers.create(@game.world.width, @game.world.height-132, 'gerter_tower_110')
    botTower2.body.immovable = true

    topTower3 = @towers.create(@game.world.width, @gerterSize-10, 'gerter_tower_110_top')
    topTower3.towerIdx = 3
    topTower3.body.immovable = true
    botTower3 = @towers.create(@game.world.width, @game.world.height-352, 'gerter_tower_330')
    botTower3.body.immovable = true

    @towersPairs = [
      {top: topTower0, bot: botTower0, alive: false, pastPlayer: false}
      {top: topTower1, bot: botTower1, alive: false, pastPlayer: false}
      {top: topTower2, bot: botTower2, alive: false, pastPlayer: false}
      {top: topTower3, bot: botTower3, alive: false, pastPlayer: false}
    ]

    # Initialize 3 towers
    t1 = @getRandomDeadTowersPair()
    t1.alive = true

    t2 = @getRandomDeadTowersPair()
    t2.alive = true
    t2.top.x += 250
    t2.bot.x += 250

    t3 = @getRandomDeadTowersPair()
    t3.alive = true
    t3.top.x += 500
    t3.bot.x += 500

    @needTower = false

  createPlayer: ->
    # Create Player
    @player = @game.add.sprite(@game.world.width/4, @game.world.height/2, 'donkey')
    @player.frame = 0
    @player.body.gravity.y = 500
    @player.isDead = false

    # Set up user input
    @game.input.keyboard.callbackContext = @
    @game.input.keyboard.onDownCallback = @onKeyDown
    @game.input.keyboard.onUpCallback = @onKeyUp
    @game.input.touch.callbackContext = @
    @game.input.touch.touchStartCallback = @onTouchStart
    @game.input.touch.touchEndCallback = @onTouchEnd

  createEdges: ->
    # Create Ceiling/Floor tiels
    @gerters = @game.add.group()
    numEdgeTiles = Math.ceil(@game.world.width / @gerterSize)
    @gerterMovePoint = numEdgeTiles * @gerterSize - @gerterSpeed
    @gertersArray = []
    for i in [0..numEdgeTiles]
      floorTile = @gerters.create(i * @gerterSize, @game.world.height - @gerterSize, 'gerter')
      floorTile.body.immovable = true
      #floorTile.events.onOutOfBounds.add(@resetGerter, @)
      @gertersArray.push(floorTile)

      ceilingTile = @gerters.create(i * @gerterSize, 0, 'gerter')
      ceilingTile.body.immovable = true
      #ceilingTile.events.onOutOfBounds.add(@resetGerter, @)
      @gertersArray.push(ceilingTile)

  createDashboard: ->
    @scoreboard = @game.add.text(10, 32, ''+@game.score, {font: '48px VT323', fill: '#fff'})
    @soundToggle = @game.add.button(@game.world.width-38, 42, 'mute', @toggleSound, @)
    if not @game.soundOn
      @soundToggle.frame = 1

  getRandomDeadTowersPair: ->
    deadTowers = @towersPairs.filter((tower) -> not tower.alive)
    deadTowers[Math.floor(Math.random() * deadTowers.length)]

  playerJump: ->
    if not @player.isDead
      if @player.body.velocity.y > -200
        # Ensure the player doesn't jump too fast
        if @player.body.velocity.y < 50
          @player.body.velocity.y = -350
        else
          @player.body.velocity.y -= 400
      @player.frame = 1

  endJump: ->
    if not @player.isDead
      @player.frame = 0

  onTouchStart: (event) ->
    @playerJump()

  onTouchEnd: (event) ->
    @endJump()

  onKeyUp: (event) ->
    if event.keyCode == Phaser.Keyboard.SPACEBAR
      @endJump()

  onKeyDown: (event) ->
    if event.keyCode == Phaser.Keyboard.SPACEBAR
      @playerJump()

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
    if not @player.isDead
      # Collide/collect against other entities
      @game.physics.collide(@player, @gerters)
      @game.physics.collide(@player, @towers)

      # Check if player should die
      if @player.body.touching.up or
          @player.body.touching.right or
          @player.body.touching.down or
          @player.body.touching.left

        # Create explosion
        @explosion = @game.add.sprite(@player.x+@player.body.width/2, @player.y+@player.body.height/2, 'explosion')
        @explosion.elapsed = 0
        @explosion.anchor.setTo(.5, .5)
        if @game.soundOn
          @game.add.audio('explosion').play('', 0, .1)

        # Update player to death
        @player.body.velocity.x = 0
        @player.body.velocity.y = 0
        @player.isDead = true
        @player.bringToTop()
        @player.body.gravity.y = 1250

        # Let player overlap these as they fall
        @gerters.setAll 'body.checkCollision.up', false
        @gerters.setAll 'body.checkCollision.right', false
        @gerters.setAll 'body.checkCollision.down', false
        @gerters.setAll 'body.checkCollision.left', false
        @gerters.setAll 'body.checkCollision.any', false
        @towers.setAll 'body.checkCollision.up', false
        @towers.setAll 'body.checkCollision.right', false
        @towers.setAll 'body.checkCollision.down', false
        @towers.setAll 'body.checkCollision.left', false
        @towers.setAll 'body.checkCollision.any', false

      else
        # Check if a new tower needs generated
        if @needTower
          @needTower = false
          pair = @getRandomDeadTowersPair()
          pair.alive = true
          pair.top.x += 300
          pair.bot.x += 300
          @towersPairs[pair.top.towerIdx] = pair

        # Update Gerter position
        for i in [0..@gertersArray.length-1]
          gerter = @gertersArray[i]
          if gerter.x + gerter.width < 0
            gerter.reset(@gerterMovePoint, gerter.y)
          gerter.x -= @gerterSpeed

        # Update Tower position
        for i in [0..@towersPairs.length-1]
          towerPair = @towersPairs[i]
          if towerPair.alive
            towerPair.top.x -= @gerterSpeed
            towerPair.bot.x -= @gerterSpeed
            rightSidePos = towerPair.top.x + towerPair.top.width
            if rightSidePos < 0
              # Reset tower if its past the screen
              towerPair.top.reset(@game.world.width+20, towerPair.top.y)
              towerPair.bot.reset(@game.world.width+20, towerPair.bot.y)
              towerPair.alive = false
              towerPair.pastPlayer = false
              @needTower = true
            else if not towerPair.pastPlayer and
                rightSidePos < @player.x
              # Update score if the tower passes the player
              towerPair.pastPlayer = true
              @game.score += 1
              @scoreboard.setText(''+@game.score)

    else # Player is dead
      @player.body.rotation -= 2

      if @player.y > @game.world.height
        if @game.score > @game.highscore
          # Switch to Dead state
          @game.highscore = @game.score
          @game.newRecord = true
        @game.state.start 'Dead'

    if @explosion?
      @explosion.elapsed += @game.time.elapsed
      if @explosion.elapsed > 100
        @explosion.destroy()
        @explosion = null


module.exports = Play
