class QuestionsController < ApplicationController
  before_filter :set_update_form

  def index
  end

  def create
    @question = @update_form.questions.create!(question_params)

    if request.xhr?
      ActionCable.server.broadcast \
        "update_form_#{@update_form.id}_questions", @question.to_json(only: [:id, :text])

      head :created
    end
  end

  private

  def set_update_form
    @update_form = UpdateForm.find(params[:update_form_id])
  end

  def question_params
    params.require(:question).permit(:text)
  end
end
