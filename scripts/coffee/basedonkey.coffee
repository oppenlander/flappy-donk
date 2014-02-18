class BaseDonkey
  constructor: (@game) ->
    @playing = false
    @gw = @game.world.width
    @gh = @game.world.height

    # Default values
    @gravity = 500
    @maxVel = -350
    @addVel = -400
    @minVel = -200
    @limitVel = 50
    @jumpAudio = @game.add.audio('jump')
    @explosionAudio = @game.add.audio('explosion')

  play: (towersPairs) ->
    @sprite.body.gravity.y = @gravity
    @playing = true
    @isDead = false

  jumpStart: ->
    if @playing and not @isDead
      if @sprite.body.velocity.y > @minVel
        # Ensure the player doesn't jump too fast
        if @sprite.body.velocity.y < @limitVel
          @sprite.body.velocity.y = @maxVel
        else
          @sprite.body.velocity.y += @addVel
        if @game.soundOn
          @jumpAudio.play('', 0, .05)
      @sprite.frame = 1

  jumpEnd: ->
    if @playing and not @isDead
      @sprite.frame = 0

  idle: ->
    if not @elapsed?
      @elapsed = 0
    @elapsed += @game.time.elapsed
    if @elapsed > 1000
      @sprite.frame = ++@sprite.frame % 2
      @elapsed = 0

  kill: ->
    # Explode
    @explosion = @game.add.sprite(@sprite.x+@sprite.body.width/2, @sprite.y+@sprite.body.height/2, 'explosion')
    @explosion.elapsed = 0
    @explosion.anchor.setTo(.5, .5)
    if @game.soundOn
      @explosionAudio.play('', 0, .1)

    # Kill
    @sprite.body.velocity.x = 0
    @sprite.body.velocity.y = 0
    @isDead = true
    @sprite.bringToTop()
    @sprite.body.gravity.y = 1250

  destroy: ->
    @sprite.destroy()

  update: ->
    if @isDead
      # Play death animation
      @sprite.body.rotation -= 2

      if @sprite.y > @gh
        if @game.score > @game.highscore
          # Switch to Dead state
          @game.highscore = @game.score
          @game.newRecord = true
        @game.state.start 'Dead'

    if @explosion?
      # Remove explosion if one is still around
      @explosion.elapsed += @game.time.elapsed
      if @explosion.elapsed > 100
        @explosion.destroy()
        @explosion = null


module.exports = BaseDonkey
