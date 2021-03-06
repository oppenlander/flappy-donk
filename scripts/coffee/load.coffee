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
    @game.load.spritesheet('donkey_squier', 'assets/images/donkey_squier.png', 48, 41)
    @game.load.spritesheet('donkey_king', 'assets/images/donkey_king.png', 48, 41)
    @game.load.spritesheet('donkey_woodfighter', 'assets/images/donkey_woodfighter.png', 48, 41)
    @game.load.spritesheet('babydonkey', 'assets/images/babydonkey.png', 24, 20)
    @game.load.spritesheet('babydonkey_squier', 'assets/images/babydonkey_squier.png', 24, 20)
    @game.load.spritesheet('babydonkey_king', 'assets/images/babydonkey_king.png', 24, 20)
    @game.load.spritesheet('babydonkey_woodfighter', 'assets/images/babydonkey_woodfighter.png', 24, 20)

    @game.load.image('gerter', 'assets/images/gerter.png')
    @game.load.image('gerterbody', 'assets/images/gerterbody.png')
    @game.load.image('gerter_tower_100', 'assets/images/gerter_tower_100.png')
    @game.load.image('gerter_tower_210', 'assets/images/gerter_tower_210.png')
    @game.load.image('gerter_tower_320', 'assets/images/gerter_tower_320.png')
    @game.load.image('gerter_tower_100_top', 'assets/images/gerter_tower_100_top.png')
    @game.load.image('gerter_tower_210_top', 'assets/images/gerter_tower_210_top.png')
    @game.load.image('gerter_tower_320_top', 'assets/images/gerter_tower_320_top.png')
    @game.load.image('gerter_tower_fire_110', 'assets/images/gerter_tower_fire_110.png')
    @game.load.image('gerter_tower_fire_220', 'assets/images/gerter_tower_fire_220.png')
    @game.load.image('gerter_tower_fire_330', 'assets/images/gerter_tower_fire_330.png')
    @game.load.image('explosion', 'assets/images/explosion.png')
    @game.load.spritesheet('mute', 'assets/images/mute.png', 28, 18)
    @game.load.image('bg', 'assets/images/bg.png')
    @game.load.spritesheet('select_bg', 'assets/images/select_bg.png', 64, 64)

    # Load Sounds
    @game.load.audio('braadslee', 'assets/sounds/braadslee.ogg', true)
    @game.load.audio('explosion', 'assets/sounds/explosion.ogg', true)
    @game.load.audio('passgate', 'assets/sounds/passgate.ogg', true)

    @game.load.audio('babysong', 'assets/sounds/babysong.ogg', true)
    @game.load.audio('jump', 'assets/sounds/babyjump.ogg', true)
    @game.load.audio('babyexplosion', 'assets/sounds/babyexplosion.ogg', true)
    @game.load.audio('babypassgate', 'assets/sounds/babypassgate.ogg', true)
    @game.load.audio('babyjump', 'assets/sounds/babyjump.ogg', true)

  create: ->
    @game.state.start('Menu')

module.exports = Load
