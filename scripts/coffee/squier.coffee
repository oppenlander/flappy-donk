BaseDonkey = require('./basedonkey')

class Squier extends BaseDonkey
  constructor: (@game) ->
    super
    spriteName = if not @game.babyMode then 'donkey_squier' else 'babydonkey_squier'
    @sprite = @game.add.sprite(@game.world.width/4, @game.world.height/2, spriteName)

    @label = if not @game.babyMode then 'Squire' else 'Baby Squire'

    #TODO: adjust hit box

    @gravity = 500
    @maxVel = -500
    @addVel = -600
    @minVel = -100
    @limitVel = 50


module.exports = Squier
