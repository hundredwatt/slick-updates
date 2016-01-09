class PublicUpdateFormsController < ApplicationController
  before_action :set_update_form
  after_action :strip_response_body, only: :update

  def show
  end

  def update
    @public_update_form = PublicUpdateForm.new(@update_form)
    @public_update_form.questions_attributes = public_update_form_params['questions_attributes']
  end

  private

  def set_update_form
    @update_form = UpdateForm.find_by! token: params[:token]
  end

  def strip_response_body
    self.response_body[0].strip!
  end

  def public_update_form_params
    params.require(:public_update_form).permit(questions_attributes: [:id, :answer])
  end
end
