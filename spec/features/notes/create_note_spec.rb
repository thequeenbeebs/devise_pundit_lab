feature 'create note' do

  let (:current_user) { User.create(name: "Hannah", email: "h@h.h", password: "ilovehatsandmops") }
  let (:amanda) { User.create(name: "Amanda", email: "a@a.a", password: "boomboomsand") }
  let (:rachel) { User.create(name: "Rachel", email: "r@r.r", password: "minimalismiscool") }
  let (:note_by_current_user) { Note.create(user: current_user) }

  scenario 'guest cannot create note' do
    visit 'notes/new'
    expect(page).to have_content('Access denied.')
  end

  scenario 'users can view new note form' do
    login_as(current_user)

    visit new_note_path
    expect(page).to have_selector('form')
  end

  scenario 'users can create a note' do
    login_as(current_user)

    visit new_note_path
    fill_in 'note_content', :with => 'I love hats and mops'
    fill_in 'note_visible_to', :with => "#{rachel.name}, #{amanda.name}"
    click_button 'save'

    expect(page).to have_text('I love hats and mops')
    expect(page).to have_text(rachel.name)
    expect(page).to have_text(amanda.name)
  end

end
