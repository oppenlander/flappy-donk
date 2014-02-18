BaseDonkey = require('./basedonkey')

class Woodfighter extends BaseDonkey
  constructor: (@game) ->
    super
    @sprite = @game.add.sprite(@game.world.width/4, @game.world.height/2, 'donkey_woodfighter')

    #TODO: adjust hit box

    @gravity = 750
    @maxVel = -350
    @addVel = -750
    @minVel = -250
    @limitVel = 50

module.exports = Woodfighter
