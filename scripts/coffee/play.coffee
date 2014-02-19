BaseState = require('./basestate')

class Play extends BaseState

  create: ->
    super

    # How fast the world is moving
    @speed = 2

    # Where to move gerters to after they pass the screen
    numEdgeTiles = Math.ceil(@gw / @gerterSize)
    @gerterMovePoint = numEdgeTiles * @gerterSize - @speed

    # Reset score
    @game.score = 0
    @game.newRecord = false

    # Preload towers
    @createTowers()

    # Create Player
    @player = new @game.donkSelection(@game)
    @player.play(@)

    # Create score and move move sound toggle up
    @scoreboard = @game.add.text(10, @gerterSize, ''+@game.score, {font: '48px VT323', fill: '#fff'})
    @soundToggle.bringToTop()

  createTowers: ->
    # Create Towers
    @towers = @game.add.group()

    if not @game.babyMode
      mdOffset = @gh - 242
      hiOffset = @gh - 352
      loOffset = @gh - 132
      topOffset = @gerterSize
    else
      mdOffset = @gh - 192
      hiOffset = @gh - 302
      loOffset = @gh - 82
      topOffset = @gerterSize - 50

    # Medium Towers
    topTower0 = @towers.create(@gw, topOffset, 'gerter_tower_210_top')
    topTower0.body.immovable = true
    botTower0 = @towers.create(@gw, mdOffset, 'gerter_tower_210')
    botTower0.body.immovable = true

    topTower1 = @towers.create(@gw, topOffset, 'gerter_tower_210_top')
    topTower1.body.immovable = true
    botTower1 = @towers.create(@gw, mdOffset, 'gerter_tower_210')
    botTower1.body.immovable = true

    topTower2 = @towers.create(@gw, topOffset, 'gerter_tower_210_top')
    topTower2.body.immovable = true
    botTower2 = @towers.create(@gw, mdOffset, 'gerter_tower_210')
    botTower2.body.immovable = true

    # Low Towers
    topTower3 = @towers.create(@gw, topOffset, 'gerter_tower_320_top')
    topTower3.body.immovable = true
    botTower3 = @towers.create(@gw, loOffset, 'gerter_tower_100')
    botTower3.body.immovable = true

    topTower4 = @towers.create(@gw, topOffset, 'gerter_tower_320_top')
    topTower4.body.immovable = true
    botTower4 = @towers.create(@gw, loOffset, 'gerter_tower_100')
    botTower4.body.immovable = true

    topTower5 = @towers.create(@gw, topOffset, 'gerter_tower_320_top')
    topTower5.body.immovable = true
    botTower5 = @towers.create(@gw, loOffset, 'gerter_tower_100')
    botTower5.body.immovable = true

    # High Towers
    topTower6 = @towers.create(@gw, topOffset, 'gerter_tower_100_top')
    topTower6.body.immovable = true
    botTower6 = @towers.create(@gw, hiOffset, 'gerter_tower_320')
    botTower6.body.immovable = true

    topTower7 = @towers.create(@gw, topOffset, 'gerter_tower_100_top')
    topTower7.body.immovable = true
    botTower7 = @towers.create(@gw, hiOffset, 'gerter_tower_320')
    botTower7.body.immovable = true

    topTower8 = @towers.create(@gw, topOffset, 'gerter_tower_100_top')
    topTower8.body.immovable = true
    botTower8 = @towers.create(@gw, hiOffset, 'gerter_tower_320')
    botTower8.body.immovable = true

    # Fire Towers
    topTower9 = @towers.create(@gw, topOffset, 'gerter_tower_210_top')
    topTower9.body.immovable = true
    botTower9 = @towers.create(@gw, mdOffset-10, 'gerter_tower_fire_220')
    botTower9.body.immovable = true

    topTower10 = @towers.create(@gw, topOffset, 'gerter_tower_320_top')
    topTower10.body.immovable = true
    botTower10 = @towers.create(@gw, loOffset-10, 'gerter_tower_fire_110')
    botTower10.body.immovable = true

    topTower11 = @towers.create(@gw, topOffset, 'gerter_tower_100_top')
    topTower11.body.immovable = true
    botTower11 = @towers.create(@gw, hiOffset-10, 'gerter_tower_fire_330')
    botTower11.body.immovable = true

    @towersPairs = [
      {top: topTower0, bot: botTower0, alive: false, pastPlayer: false}
      {top: topTower1, bot: botTower1, alive: false, pastPlayer: false}
      {top: topTower2, bot: botTower2, alive: false, pastPlayer: false}
      {top: topTower3, bot: botTower3, alive: false, pastPlayer: false}
      {top: topTower4, bot: botTower4, alive: false, pastPlayer: false}
      {top: topTower5, bot: botTower5, alive: false, pastPlayer: false}
      {top: topTower6, bot: botTower6, alive: false, pastPlayer: false}
      {top: topTower7, bot: botTower7, alive: false, pastPlayer: false}
      {top: topTower8, bot: botTower8, alive: false, pastPlayer: false}
      {top: topTower9, bot: botTower9, alive: false, pastPlayer: false}
      {top: topTower10, bot: botTower10, alive: false, pastPlayer: false}
      {top: topTower11, bot: botTower11, alive: false, pastPlayer: false}
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

  getRandomDeadTowersPair: ->
    deadTowers = @towersPairs.filter((tower) -> not tower.alive)
    deadTowers[Math.floor(Math.random() * deadTowers.length)]

  onTouchStart: (event) ->
    @player.jumpStart()

  onTouchEnd: (event) ->
    @player.jumpEnd()

  onKeyUp: (event) ->
    if event.keyCode == Phaser.Keyboard.SPACEBAR
      @player.jumpEnd()
    else if event.keyCode == Phaser.Keyboard.R
      @game.state.start('Play')
    else
      super

  onKeyDown: (event) ->
    if event.keyCode == Phaser.Keyboard.SPACEBAR
      @player.jumpStart()
    else if event.keyCode == Phaser.Keyboard.P
      @toggleSound()
    else
      super

  update: ->
    super
    if not @player.isDead
      # Collide/collect against other entities
      @game.physics.collide(@player.sprite, @gerters)
      @game.physics.collide(@player.sprite, @towers)

      # Check if player should die
      if @player.sprite.body.touching.up or
          @player.sprite.body.touching.right or
          @player.sprite.body.touching.down or
          @player.sprite.body.touching.left

        # Kill player
        @player.kill()

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

        # Update Gerter position
        for i in [0..@gertersArray.length-1]
          gerter = @gertersArray[i]
          if gerter.x + gerter.width < 0
            gerter.reset(@gerterMovePoint, gerter.y)
          gerter.x -= @speed

        # Update Tower position
        for i in [0..@towersPairs.length-1]
          towerPair = @towersPairs[i]
          if towerPair.alive
            towerPair.top.x -= @speed
            towerPair.bot.x -= @speed
            rightSidePos = towerPair.top.x + towerPair.top.width
            if rightSidePos < 0
              # Reset tower if its past the screen
              towerPair.top.reset(@gw+20, towerPair.top.y)
              towerPair.bot.reset(@gw+20, towerPair.bot.y)
              towerPair.alive = false
              towerPair.pastPlayer = false
              @needTower = true
            else if not towerPair.pastPlayer and
                rightSidePos < @player.sprite.x
              # Update score if the tower passes the player
              towerPair.pastPlayer = true
              @game.score += 1
              @scoreboard.setText(''+@game.score)
              if @game.soundOn
                if not @game.babyMode
                  @game.add.audio('passgate').play('', 0, .1)
                else
                  @game.add.audio('babypassgate').play('', 0, .2)

    # Update player
    @player.update()

module.exports = Play
