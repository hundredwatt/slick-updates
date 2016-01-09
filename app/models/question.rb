class Question < ApplicationRecord
  belongs_to :update_form

  validates :text, presence: true
end
