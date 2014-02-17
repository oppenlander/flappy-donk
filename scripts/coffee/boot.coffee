BaseState = require './basestate'

class Boot extends BaseState

  preload: ->
    # Initial setup for loading
    @game.stage.backgroundColor = '#000000'
    @game.load.image('loading', '/assets/images/loading.png')

  create: ->
    @game.state.start('Load')

module.exports = Boot
