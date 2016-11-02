# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

datetime = undefined

update = ->
    $.each datetime, (key, value) ->
        diffTime = calculateDiff($(value).data('start-time'))

        $(value).html diffTime
        
        return
    return

calculateDiff = (startDate) ->
    date      = moment(new Date)
    startDate = moment(startDate)

    date     = date.diff(startDate)
    diffTime = moment.duration(date)

    days    = diffTime.days()
    hours   = diffTime.hours()
    minutes = diffTime.minutes()
    seconds = diffTime.seconds()

    if days > 0
        hours = days * 24 + hours
    if hours < 10
        hours = '0' + hours
    if minutes < 10
        minutes = '0' + minutes
    if seconds < 10
        seconds = '0' + seconds

    hours + ':' + minutes + ':' + seconds

$(document).on 'turbolinks:load', ->
    datetime = $('.js-entry-time-ellapsed')
    update()
    setInterval update, 1000
    return
