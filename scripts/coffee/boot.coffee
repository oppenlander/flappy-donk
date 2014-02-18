BaseState = require './basestate'

class Boot extends BaseState

  preload: ->
    # Initial setup for loading
    @game.stage.backgroundColor = '#000000'
    @game.load.image('loading', 'assets/images/loading.png')

  create: ->
    if @game.device.android or @game.device.iOS
      @game.isMobile = true
    else
      @game.isMobile = false

    @game.state.start('Load')

module.exports = Boot
