BaseDonkey = require('./basedonkey')

class Woodfighter extends BaseDonkey
  constructor: (@game) ->
    super
    spriteName = if not @game.babyMode then 'donkey_woodfighter' else 'babydonkey_woodfighter'
    @sprite = @game.add.sprite(@game.world.width/4, @game.world.height/2, spriteName)

    @label = if not @game.babyMode then 'Woodfighter' else 'Baby Woodfghtr'

    #TODO: adjust hit box

    @gravity = 750
    @maxVel = -350
    @addVel = -750
    @minVel = -250
    @limitVel = 50

module.exports = Woodfighter
