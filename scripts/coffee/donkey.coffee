BaseDonkey = require('./basedonkey')

class Donkey extends BaseDonkey
  constructor: (@game)->
    super
    @sprite = @game.add.sprite(@game.world.width/4, @game.world.height/2, 'donkey')

    #TODO: adjust hit box

    @gravity = 500
    @maxVel = -350
    @addVel = -400
    @minVel = -200
    @limitVel = 50

module.exports = Donkey
