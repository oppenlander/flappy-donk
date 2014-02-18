BaseState = require('./basestate')
Donkey = require('./donkey')
Squier = require('./squier')
King = require('./king')
Woodfighter = require('./woodfighter')


class Menu extends BaseState

  create: ->
    super

    # Show Top score
    if not @game.highscore
      @game.highscore = 0
    highscoreLabel = @game.add.text(0, @gh-74, 'Highscore: '+@game.highscore, {font: '32px VT323', fill: '#fff'})
    highscoreLabel.x = @gw - (highscoreLabel._width + 10)

    flappyLabel = @game.add.text(0, 42, 'FLAPPY', {font: '96px VT323', fill: '#fff'})
    flappyLabel.x = @gw/2 - flappyLabel._width/2
    donkLabel = @game.add.text(0, 118, 'DONK', {font: '96px VT323', fill: '#fff'})
    donkLabel.x = @gw/2 - donkLabel._width/2
    descLabel = @game.add.text(0, 224, 'A realistic barrel jumping simulator', {font: '16px VT323', fill: '#fff'})
    descLabel.x = @gw/2 - descLabel._width/2
    versionLabel = @game.add.text(0, 248, 'Patch v0.0.0.0.0.23.0.2', {font: '16px VT323', fill: '#fff'})
    versionLabel.x = @gw/2 - versionLabel._width/2
    startLabel = @game.add.text(10, @gh-74, 'Start: SPACE', {font: '32px VT323', fill: '#fff'})

    @createIdle()
    @createDonkSelection()

  createDonkSelection: ->
    console.log('Donk selection!')
    @donks = [
      Donkey
      Squier
      King
      Woodfighter
    ]
    @selectDonkey = new Donkey(@game)
    @selectDonkey.sprite.anchor.setTo(.5, .5)
    @selectDonkey.sprite.x = @gw / 8
    @selectDonkey.sprite.y = @gh * 3 / 4
    buttonDonkey = @game.add.button(0, 0, 'select_bg', @changeDonkDonkey, @, 0, 1, 2)
    buttonDonkey.x = @selectDonkey.sprite.x - 32
    buttonDonkey.y = @selectDonkey.sprite.y - 32
    @selectDonkey.sprite.bringToTop()
    textDonkey = @game.add.text(0, 0, 'Donkey', {font: '16px VT323', fill: '#fff'})
    textDonkey.anchor.setTo(.5, .5)
    textDonkey.x = @selectDonkey.sprite.x
    textDonkey.y = buttonDonkey.y + 70

    @selectSquier = new Squier(@game)
    @selectSquier.sprite.anchor.setTo(.5, .5)
    @selectSquier.sprite.x = @gw * 3 / 8
    @selectSquier.sprite.y = @gh * 3 / 4
    buttonSquier = @game.add.button(0, 0, 'select_bg', @changeDonkSquier, @, 0, 1, 2)
    buttonSquier.x = @selectSquier.sprite.x - 32
    buttonSquier.y = @selectSquier.sprite.y - 32
    @selectSquier.sprite.bringToTop()
    textSquier = @game.add.text(0, 0, 'Squier', {font: '16px VT323', fill: '#fff'})
    textSquier.anchor.setTo(.5, .5)
    textSquier.x = @selectSquier.sprite.x
    textSquier.y = buttonSquier.y + 70

    @selectKing = new King(@game)
    @selectKing.sprite.anchor.setTo(.5, .5)
    @selectKing.sprite.x = @gw * 5 / 8
    @selectKing.sprite.y = @gh * 3 / 4
    buttonKing = @game.add.button(0, 0, 'select_bg', @changeDonkKing, @, 0, 1, 2)
    buttonKing.x = @selectKing.sprite.x - 32
    buttonKing.y = @selectKing.sprite.y - 32
    @selectKing.sprite.bringToTop()
    textKing = @game.add.text(0, 0, 'King', {font: '16px VT323', fill: '#fff'})
    textKing.anchor.setTo(.5, .5)
    textKing.x = @selectKing.sprite.x
    textKing.y = buttonKing.y + 70

    @selectWoodfighter = new Woodfighter(@game)
    @selectWoodfighter.sprite.anchor.setTo(.5, .5)
    @selectWoodfighter.sprite.x = @gw * 7 / 8
    @selectWoodfighter.sprite.y = @gh * 3 / 4
    buttonWoodfighter = @game.add.button(0, 0, 'select_bg', @changeDonkWoodfighter, @, 0, 1, 2)
    buttonWoodfighter.x = @selectWoodfighter.sprite.x - 32
    buttonWoodfighter.y = @selectWoodfighter.sprite.y - 32
    @selectWoodfighter.sprite.bringToTop()
    textWoodfighter = @game.add.text(0, 0, 'Woodfighter', {font: '16px VT323', fill: '#fff'})
    textWoodfighter.anchor.setTo(.5, .5)
    textWoodfighter.x = @selectWoodfighter.sprite.x
    textWoodfighter.y = buttonWoodfighter.y + 70

  getDonkIndex: () ->
    if @game.donkSelection == Donkey
      0
    else if @game.donkSelection == Squier
      1
    else if @game.donkSelection == King
      2
    else if @game.donkSelection == Woodfighter
      3
    else
      0

  changeDonkDonkey: ->
    @changeDonk(Donkey)

  changeDonkSquier: ->
    @changeDonk(Squier)

  changeDonkKing: ->
    @changeDonk(King)

  changeDonkWoodfighter: ->
    @changeDonk(Woodfighter)

  changeDonk: (donk) ->
    @game.donkSelection = donk
    @player.destroy()
    @player = new donk(@game)

  onKeyDown: (event) ->
    if event.keyCode == Phaser.Keyboard.LEFT
      @changeDonk(@donks[(@getDonkIndex() + 3) % 4])
    else if event.keyCode == Phaser.Keyboard.RIGHT
      @changeDonk(@donks[(@getDonkIndex() + 1) % 4])
    else
      super

  update: ->
    super
    @player.idle()
    @selectDonkey.idle()
    @selectSquier.idle()
    @selectKing.idle()
    @selectWoodfighter.idle()

module.exports = Menu
