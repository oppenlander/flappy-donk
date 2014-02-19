BaseDonkey = require('./basedonkey')

class King extends BaseDonkey
  constructor: (@game) ->
    super
    spriteName = if not @game.babyMode then 'donkey_king' else 'babydonkey_king'
    @sprite = @game.add.sprite(@game.world.width/4, @game.world.height/2, spriteName)

    @label = if not @game.babyMode then 'King' else 'Baby King'

    #TODO: adjust hit box

    @gravity = 500
    @maxVelocity = -200
    @jumpVel = @maxVelocity
    @canJumpVel = @maxVelocity

module.exports = King
