class UpdateFormPolicy < UpdateFormBasePolicy

  def show?
    can_collaborate?
  end
  
  def create?
    is_owner?
  end

  def destroy?
    is_owner?
  end
end
