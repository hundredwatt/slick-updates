module ApplicationHelper
  # View helper to set the page title
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def publicize(update_form)
    PublicUpdateForm.new(update_form)
  end
end
