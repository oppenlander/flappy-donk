BaseDonkey = require('./basedonkey')

class Woodfighter extends BaseDonkey
  constructor: (@game) ->
    super
    @sprite = @game.add.sprite(@game.world.width/4, @game.world.height/2, 'donkey_woodfighter')

    #TODO: adjust hit box

    @gravity = 500
    @maxVel = -350
    @addVel = -400
    @minVel = -200
    @limitVel = 50

  play: (towersPairs) ->
    super
    #TODO: adjust the body of fire towers

module.exports = Woodfighter
