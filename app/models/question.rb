class Question < ApplicationRecord
  belongs_to :update_form

  validates :text, presence: true

  attr_accessor :answer

  before_create do
    self.position = next_position_number
  end

  after_update do
    ActionCable.server.broadcast \
      "update_form_#{update_form_id}_questions", as_json(only: [:id, :text, :position]).merge(updated: true)
  end

  default_scope -> { order('position') }

  private

  def next_position_number
    (update_form.questions.maximum(:position) || 0) + 1
  end
end
