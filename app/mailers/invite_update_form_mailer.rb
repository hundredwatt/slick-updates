class InviteUpdateFormMailer < ApplicationMailer
  
  def notify(user, update_form)
    @invited_user = user
    @update_form  = update_form
    mail(to: @invited_user.email, subject: 'Invited to collaborate')
  end
  
  def invite_to_signup(user, update_form)
    @invited_user = user
    @update_form  = update_form
    mail(to: @invited_user.email, subject: 'Invited to signup & collaborate')
  end
end
