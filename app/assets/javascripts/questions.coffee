# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('form.new_question').on('ajax:success', (e, data, status, xhr) ->
    $(this).find('#question_text').val('')
  ).on('submit', (e)->
    $('p.empty-questions').remove()
  )
