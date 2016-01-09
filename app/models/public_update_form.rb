class PublicUpdateForm
  include ActiveModel::Model

  attr_accessor :update_form

  delegate :persisted?, :questions, to: :update_form

  def initialize(*args)
    return super unless args.first.is_a?(UpdateForm)

    @update_form = args.first
  end

  def questions_attributes=(attributes)
    attributes.each do |_, question_attributes|
      questions.detect { |q| q.id.to_s == question_attributes['id'] }.tap do |question|
        question.answer = question_attributes['answer']
      end
    end
  end

  def to_param
    update_form.token
  end
end
