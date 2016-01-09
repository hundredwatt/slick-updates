class UpdateForm < ApplicationRecord
  has_many :questions

  has_secure_token

  def swap_questions(question1_id, question2_id)
    question1, question2 = [question1_id, question2_id].map { |id| questions.find(id) }
    position1, position2 = [question1, question2].map(&:position)

    question1.position, question2.position = position2, position1

    Question.transaction do
      [question1, question2].each(&:save!)
    end
  end
end
