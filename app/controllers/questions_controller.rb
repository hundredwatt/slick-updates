class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_update_form
  before_action :set_question, only: [:destroy]

  def index
    authorize @update_form, :show?
  end

  def create
    authorize @update_form, :show?
    @question = @update_form.questions.create!(create_params)

    if request.xhr?
      ActionCable.server.broadcast \
        "update_form_#{@update_form.id}_questions", { html: render(@question) }

      head :created
    end
  end

  def destroy
    authorize @question
    @question.destroy!

    if request.xhr?
      ActionCable.server.broadcast \
        "update_form_#{@update_form.id}_questions", { id: @question.id, destroyed: true }

      head :no_content
    end
  end

  private

  def set_update_form
    @update_form = UpdateForm.find(params[:update_form_id])
  end

  def set_question
    @question = @update_form.questions.find(params[:id])
  end

  def create_params
    params.require(:question).permit(:text)
  end
end
