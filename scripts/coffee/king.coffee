BaseDonkey = require('./basedonkey')

class King extends BaseDonkey
  constructor: (@game) ->
    super
    @sprite = @game.add.sprite(@game.world.width/4, @game.world.height/2, 'donkey_king')

    #TODO: adjust hit box

    @gravity = 500
    @maxVelocity = -200
    @jumpVel = @maxVelocity
    @canJumpVel = @maxVelocity

module.exports = King
