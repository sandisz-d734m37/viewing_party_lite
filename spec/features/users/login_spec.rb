require "rails_helper"

describe "login page" do
  describe "as a user" do
    describe "when i visit the log in page" do
      before do
        @user_1 = User.create!(name: "Tony Soprano", email: "wokeupthismorning@gmail.com", password: 'test', password_confirmation: 'test')
        @user_2 = User.create!(name: "Junior Soprano", email: "varsityathlete@gmail.com", password: 'test', password_confirmation: 'test')
        visit "/login"
      end

      it "has a form to log in and logs you in if password is correct" do
        fill_in "Email", with: "varsityathlete@gmail.com"
        fill_in "Password", with: "test"
        click_button "Log in"

        expect(current_path).to eq("/users/#{@user_2.id}")
      end

      it "shows error if password is incorrect" do
        fill_in "Email", with: "varsityathlete@gmail.com"
        fill_in "Password", with: "wrong"
        click_button "Log in"

        expect(current_path).to eq("/login")
        expect(page).to have_content("Invalid email or password")
      end

      it "shows error if email is incorrect" do
        fill_in "Email", with: "regular_athlete@gmail.com"
        fill_in "Password", with: "test"
        click_button "Log in"

        expect(current_path).to eq("/login")
        expect(page).to have_content("Invalid email or password")
      end
    end
  end
end
