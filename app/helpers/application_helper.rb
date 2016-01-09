module ApplicationHelper
  def publicize(update_form)
    PublicUpdateForm.new(update_form)
  end
end
