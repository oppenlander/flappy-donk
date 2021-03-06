BaseDonkey = require('./basedonkey')

class Donkey extends BaseDonkey
  constructor: (@game) ->
    super
    @spriteName = if not @game.babyMode then 'donkey' else 'babydonkey'
    @sprite = @game.add.sprite(@game.world.width/4, @game.world.height/2, @spriteName)

    @label = if not @game.babyMode then 'Donkey' else 'Baby Donkey'

    #TODO: adjust hit box

    @gravity = 600
    @maxVelocity = -350
    @jumpVel = -400
    @canJumpVel = -200

module.exports = Donkey
