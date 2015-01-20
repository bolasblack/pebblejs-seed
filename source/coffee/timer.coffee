
{EventEmitter} = require 'events'

module.exports = class Timer extends EventEmitter
  @formatTime: (leftSecond) ->
    moment.unix(leftSecond).format 'mm:ss'

  constructor: (@targetSecond) ->
    @running = false
    return

  start: ->
    @running = true
    @startedAt = moment().toDate()
    @emit 'start', @targetSecond
    @emit 'timeupdate', @targetSecond
    @timer = setInterval =>
      return unless @running
      leftSecond = @leftSecond()
      @emit 'timeupdate', leftSecond
      @emit 'timeup', leftSecond if leftSecond is 0
    , 1000

  stop: ->
    @running = false
    @startedAt = null
    @emit 'stop', @targetSecond
    clearInterval @timer

  leftSecond: ->
    return @targetSecond unless @running
    targetTime = moment(@startedAt).add(@targetSecond, 's').unix()
    currentTime = moment().unix()
    leftSecond = targetTime - currentTime
    if leftSecond < 0 then 0 else leftSecond
