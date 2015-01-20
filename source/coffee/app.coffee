
Vector2 = require 'vector2'
UI = require 'ui'
Vibe = require 'ui/vibe'
Timer = require './timer'

SCREEN_WIDTH = 144
SCREEN_HEIGHT = 168

#timer = new Timer 25 * 60
timer = new Timer 5

pomoTimer = new UI.Window(
  fullscreen: true
  clear: true
  backgroundColor: 'white'
)

timeBG = new UI.Rect(
  position: new Vector2(0, 0)
  size: new Vector2(SCREEN_WIDTH, SCREEN_HEIGHT)
  backgroundColor: 'white'
)

timeText = new UI.Text(
  position: new Vector2(0, (SCREEN_HEIGHT - 52) / 2)
  textAlign: 'center'
  backgroundColor: 'white'

  text: Timer.formatTime timer.leftSecond()
  size: new Vector2(SCREEN_WIDTH, 52)
  font: 'bitham-42-bold'
  color: 'black'
)

updateTimeText = (leftSecond) ->
  timeText.text Timer.formatTime leftSecond

pomoTimer.on 'click', 'select', ->
  method = if timer.running then 'stop' else 'start'
  timer[method]()

timer.on 'timeupdate', updateTimeText
timer.on 'start', updateTimeText
timer.on 'stop', updateTimeText
timer.on 'timeup', ->
  Vibe.vibrate 'double'

pomoTimer.add timeBG
pomoTimer.add timeText
pomoTimer.show()
