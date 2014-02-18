BaseState = require('./basestate')

class Dead extends BaseState

  create: ->
    super

    if @game.newRecord
      # New record!
      responseLabel1 = @game.add.text(0, 42, 'Congrats!', {font: '96px VT323', fill: '#fff'})
      responseLabel2 = @game.add.text(0, 138, 'New Record', {font: '64px VT323', fill: '#fff'})
    else
      # Do better
      responseLabel1 = @game.add.text(0, 42, 'Failure!', {font: '96px VT323', fill: '#fff'})
      responseLabel2 = @game.add.text(0, 138, 'What the donk?', {font: '64px VT323', fill: '#fff'})
    responseLabel1.x = @game.world.width/2 - responseLabel1._width/2
    responseLabel2.x = @game.world.width/2 - responseLabel2._width/2

    # Create labels
    highscoreLabel = @game.add.text(0, @game.world.height-190, 'Highscore: '+@game.highscore, {font: '64px VT323', fill: '#fff'})
    highscoreLabel.x = @game.world.width/2 - highscoreLabel._width/2

    scoreLabel = @game.add.text(0, @game.world.height-116, 'Score: '+@game.score, {font: '48px VT323', fill: '#fff'})
    scoreLabel.x = @game.world.width/2 - scoreLabel._width/2

    restartLabel = @game.add.text(10, @game.world.height-58, 'Restart: SPACE', {font: '16px VT323', fill: '#fff'})

    menuLabel = @game.add.text(0, @game.world.height-58, 'Menu/Character Select: M', {font: '16px VT323', fill: '#fff'})
    menuLabel.x = @game.world.width - (menuLabel._width + 10)

    creditsLabel = @game.add.text(0, @game.world.height-78, 'Credits: C', {font: '16px VT323', fill: '#fff'})
    creditsLabel.x = @game.world.width - (creditsLabel._width + 10)

    @createIdle()

  update: ->
    super
    @player.idle()

module.exports = Dead
