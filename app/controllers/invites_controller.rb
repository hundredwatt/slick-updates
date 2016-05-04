class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_update_form
  before_action :authorization_update_form

  def create
    @existing_user = true
    new_user = find_new_user(params[:invite_user_email].strip.try(:downcase))
    
    collaborator = @update_form.collaborators.where(user_id: new_user.id).first
    if collaborator.present? || @update_form.is_owner?(new_user)
      flash[:error] = "User is already invited to collaborate on Update Form"
    else
      @update_form.collaborators.create(user_id: new_user.id)
      if new_user.is_logged_in?
        # Send Action Cable notification to logged in user
        ActionCable.server.broadcast \
          "logged_in_#{new_user.id}", { message: prepare_message }
      elsif @existing_user
        # Email should be delivered through sidekiq/resque or any other background processor
        # Notify to collaborate on udpate form
        InviteUpdateFormMailer.notify(new_user, @update_form).deliver_now
      else
        # Invite to signup and collaborate on update form
        InviteUpdateFormMailer.invite_to_signup(new_user, @update_form).deliver_now
      end
      flash[:notice] = "User has been invited on Update Form to collaborate"
    end
    redirect_to update_form_questions_path(@update_form)
  end
  
  def destroy
    @collaborator = @update_form.collaborators.where(id: params[:id]).first 
    @collaborator.destroy!
    flash[:notice] = "Collaborator has been removed from Update Form"
    redirect_to update_form_questions_path(@update_form)
  end
  
  private
  def set_update_form
    @update_form = UpdateForm.where(id: params[:update_form_id]).first
  end
  
  def authorization_update_form
    authorize @update_form, :is_owner?
  end
  
  def find_new_user(email)
    new_user = User.find_by_email(email)
    if new_user.blank?
      new_user = User.create(email: email) 
      @existing_user = false
    end
    
    if new_user.new_record? && new_user.errors.present?
      flash[:error] = "Please enter valid email address."
      redirect_to update_form_questions_path(@update_form) and return
    else
      new_user
    end
  end
  
  def prepare_message
    "You are invited to collaborator on Update Form #{@update_form.name}. #{view_context.link_to 'click here', update_form_questions_path(@update_form)} to view the Update Form.".html_safe
  end
  
end
