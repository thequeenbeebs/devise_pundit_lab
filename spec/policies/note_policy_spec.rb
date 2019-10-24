describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryBot.build_stubbed :user }
  let (:other_user) { FactoryBot.build_stubbed :user }
  let (:admin) { FactoryBot.build_stubbed :user, :admin }
  let (:moderator) { FactoryBot.build_stubbed :user, :moderator }
  let (:note_by_other_user) { Note.create(user: other_user) }
  let (:note_by_current_user) { Note.create(user: current_user) }
  let (:note_by_moderator) { Note.create(user: moderator) }
  let (:note_by_admin) { Note.create(user: admin) }

  permissions :create? do
    it "allows access for a normal user" do
      expect(subject).to permit(current_user)
    end
    it "allows access for a moderator" do
      expect(subject).to permit(moderator)
    end
    it "allows access for an admin" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "allows normal users to update their own notes" do
      expect(subject).to permit(current_user, note_by_current_user)
    end
    it "does not allow normal users to update notes belonging to other users" do
      expect(subject).not_to permit(current_user, note_by_other_user)
    end
    it "allows a moderator to make updates to their own notes" do
      expect(subject).to permit(moderator, note_by_moderator)
    end
    it "does not allow a moderator to make updates to other's notes" do
      expect(subject).not_to permit(moderator, note_by_other_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "allows a user to delete their own post" do
      expect(subject).to permit(current_user, note_by_current_user)
    end
    it "does not allow a user to delete a post by another user" do
      expect(subject).not_to permit(current_user, note_by_other_user)
    end
    it "allows a moderator to delete their own post" do
      expect(subject).to permit(moderator, note_by_moderator)
    end
    it "does not allow a moderator to delete a post by another user" do
      expect(subject).not_to permit(moderator, note_by_other_user)
    end
    it "allows an admin to delete their own post" do
      expect(subject).to permit(admin, note_by_admin)
    end
    it "allows an admin to delete a post by another user" do
      expect(subject).to permit(admin, note_by_other_user)
    end
  end

  permissions :visible_to? do
    it "allows a user to add or remove viewers on their post" do
      expect(subject).to permit(current_user, note_by_current_user)
    end
    it "allows admin to add or remove viewer on another user's post" do
      expect(subject).to permit(admin, note_by_current_user)
      expect(subject).to permit(admin, note_by_other_user)
      expect(subject).to permit(admin, note_by_admin)
      expect(subject).to permit(admin, note_by_moderator)
    end
  end

  permissions :show? do
    it "allows users to see their own notes" do
      expect(subject).to permit(current_user, note_by_current_user)
    end
    it "allows users to see notes on which they are a viewer" do
      note = Note.new(user: other_user, readers: [current_user])

      expect(subject).to permit(current_user, note)
    end
    it "does not allow users to see notes on which they are not a viewer" do
      note = Note.new(user: other_user, readers: [admin])

      expect(subject).not_to permit(current_user, note)
    end
    it "allows moderators to see any note" do
      expect(subject).to permit(moderator, note_by_current_user)
      expect(subject).to permit(moderator, note_by_admin)
    end
    it "allows admins to see any notes" do
      expect(subject).to permit(admin)
    end
  end
end
