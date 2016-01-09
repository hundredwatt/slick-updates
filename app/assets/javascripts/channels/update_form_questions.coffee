$ ->
  App.cable.subscriptions.create { channel: "UpdateFormQuestionsChannel", update_form_id: $('#questions').data('update_form_id') },
    received: (data) ->
      if data.destroyed
        $('#questions').find("#question_#{data.id}").remove()
      else
        $('#questions').append("<li id='question_#{data.id}'>#{data.text}</li>")
