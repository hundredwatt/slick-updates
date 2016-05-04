class UpdateFormBasePolicy
  attr_reader :user, :update_form

  def initialize(user, update_form)
    @user = user
    @update_form = update_form
  end

  def can_collaborate?
    is_owner? || is_collaborator?
  end
  
  def is_collaborator?
    update_form.collaborators.where(user_id: user.id).first.present?
  end
  
  def is_owner?
    update_form.is_owner?(user)
  end
end
