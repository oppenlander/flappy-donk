BaseState = require './basestate'

class Load extends BaseState

  preload: ->
    # Set Preloading image
    preloading = @game.add.sprite(@game.world.width/2, @game.world.height/2+19, 'loading')
    preloading.x -= preloading.width/2
    @game.load.setPreloadSprite(preloading)

    # Preloading text
    loadingText = @game.add.text(0, @game.world.height/2-23, 'loading...', {font: '32px VT323', fill: '#fff'})
    loadingText.x = @game.world.width/2 - loadingText._width/2

    # Load Images
    @game.load.spritesheet('donkey', 'assets/images/donkey.png', 48, 41)
    @game.load.image('gerter', 'assets/images/gerter.png')
    @game.load.image('gerter_tower_110', 'assets/images/gerter_tower_110.png')
    @game.load.image('gerter_tower_170', 'assets/images/gerter_tower_170.png')
    @game.load.image('gerter_tower_220', 'assets/images/gerter_tower_220.png')
    @game.load.image('gerter_tower_270', 'assets/images/gerter_tower_270.png')
    @game.load.image('gerter_tower_330', 'assets/images/gerter_tower_330.png')
    @game.load.image('gerter_tower_110_top', 'assets/images/gerter_tower_110_top.png')
    @game.load.image('gerter_tower_170_top', 'assets/images/gerter_tower_170_top.png')
    @game.load.image('gerter_tower_220_top', 'assets/images/gerter_tower_220_top.png')
    @game.load.image('gerter_tower_270_top', 'assets/images/gerter_tower_270_top.png')
    @game.load.image('gerter_tower_330_top', 'assets/images/gerter_tower_330_top.png')
    @game.load.image('explosion', 'assets/images/explosion.png')
    @game.load.spritesheet('mute', 'assets/images/mute.png', 28, 18)
    @game.load.image('background', 'assets/images/background.png')

    # Load Sounds
    @game.load.audio('braadslee', 'assets/sounds/braadslee.mp3', true)

  create: ->
    @game.state.start('Menu')

module.exports = Load
