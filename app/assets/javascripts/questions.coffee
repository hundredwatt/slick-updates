# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  App.cable.subscriptions.create { channel: "UpdateFormQuestionsChannel", update_form_id: $('#questions').data('update_form_id') },
    received: (data) ->
      $('#questions').append("<li>#{JSON.parse(data).text}</li>")

  $('form.new_question').on('ajax:success', (e, data, status, xhr) ->
    $(this).find('#question_text').val('')
  ).on('submit', (e)->
    $('p.empty-questions').remove()
  )
