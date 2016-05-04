class QuestionPolicy < UpdateFormBasePolicy
  attr_reader :user, :question, :update_form

  def initialize(user, question)
    @user = user
    @question = question
    @update_form = question.update_form
  end

  def index?
    can_collaborate?
  end
  
  def create?
    can_collaborate?
  end

  def destroy?
    can_collaborate?
  end

end
