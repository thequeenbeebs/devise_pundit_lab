class NotePolicy < ApplicationPolicy

  def new?
    !!user
  end

  def create?
    user.moderator? || user.admin? || user.user?
  end

  def edit?
    if user
      user.admin? || record.try(:user) == user
    end
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    if user
      user.admin? || record.try(:user) == user
    end
  end

  def visible_to?
    user.admin? || record.try(:user) == user
  end

  def show?
    if user
      user.admin? || user.moderator? || record.try(:user) == user || record.try(:readers).include?(user)
    end
  end
end
