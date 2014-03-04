class BaseDonkey
  constructor: (@game) ->
    @playing = false
    @gw = @game.world.width
    @gh = @game.world.height

    # Default values
    @gravity = 500
    @gravity = 500
    @maxVelocity = -350
    @jumpVel = -400
    @canJumpVel = -200

    jumpName = if not @game.babyMode then 'jump' else 'babyjump'
    @jumpAudio = @game.add.audio(jumpName)

    explosionName = if not @game.babyMode then 'explosion' else 'babyexplosion'
    @explosionAudio = @game.add.audio(explosionName)

    @canJump = not @game.isMobile

  play: (state) ->
    @sprite.body.gravity.y = @gravity
    @playing = true
    @isDead = false

  jumpStart: ->
    if not @canJump
      # Surpress extra onTouchStarts causing extra jumps
      return
    if @playing and not @isDead
      if @sprite.body.velocity.y > @canJumpVel
        @sprite.body.velocity.y += @jumpVel
        if @sprite.body.velocity < @maxVelocity
          @sprite.body.velocity.y = @maxVelocity

        if @game.soundOn
          @jumpAudio.play('', 0, .1)
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
