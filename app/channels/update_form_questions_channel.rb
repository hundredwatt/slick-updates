# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class UpdateFormQuestionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "update_form_#{params[:update_form_id]}_questions"
  end

  def swap(data)
    update_form.swap_questions(data['question1_id'], data['question2_id'])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def update_form
    @update_form ||= UpdateForm.find(params[:update_form_id])
  end
end
