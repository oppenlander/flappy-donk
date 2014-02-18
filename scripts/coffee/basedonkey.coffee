class BaseDonkey
  constructor: (@game) ->
    @playing = false

    # Default values
    @gravity = 500
    @maxVel = -350
    @addVel = -400
    @minVel = -200
    @limitVel = 50
    @jumpAudio = @game.add.audio('jump')

  play: ->
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

module.exports = BaseDonkey
