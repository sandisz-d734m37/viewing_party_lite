require 'rails_helper'

describe "User dashboard/show" do
  before do
    @user1 = User.create!(name: "User One", email: "user1@test.com")
    @user2 = User.create!(name: "User Two", email: "user2@test.com")
    @user3 = User.create!(name: "User Three", email: "user3@test.com")

    @u1_vp = Party.create!(event_date: Time.new(2002, 04, 26, 1, 0, 0), duration: "230 mins", start_time: Time.new(2002, 04, 26, 1, 0, 0), user_id: @user1.id)
    @u1_vp_inv = Invitation.create!(user_id: @user3.id, party_id: @u1_vp.id)

    @u2_vp = Party.create!(event_date: Time.new(2002, 02, 24, 2, 0, 0), duration: "230 mins", start_time: Time.new(2002, 02, 24, 2, 0, 0), user_id: @user2.id)
    @u2_vp_inv = Invitation.create!(user_id: @user3.id, party_id: @u2_vp.id)
    visit "/users/#{@user1.id}"
  end

  it 'displays the users name' do
    expect(page).to have_content("User One's page")
    expect(page).not_to have_content("User Two's page")
  end

  it 'has a button to discover movies' do
    click_button("Discover Movies")

    expect(current_path).to eq("/users/#{@user1.id}/discover")
    expect(current_path).not_to eq("/users/#{@user2.id}/discover")
  end

  it 'has a section that lists viewing parties' do
    within "#viewing_parties" do
      expcet(page).to have_content("Host: User One")
      expcet(page).to have_content("Invited: User Three")

      expcet(page).not_to have_content("Host: User Two")
    end
  end
end
