require "rails_helper"

describe "login page" do
  describe "as a user" do
    describe "when i visit the log in page" do
      before do
        @user_1 = User.create!(name: "Tony Soprano", email: "wokeupthismorning@gmail.com", password: 'test', password_confirmation: 'test')
        @user_2 = User.create!(name: "Junior Soprano", email: "varsityathlete@gmail.com", password: 'test', password_confirmation: 'test')
        visit "/login"
      end

      it "has a form to log in" do
        fill_in "Email", with: "varsityathlete@gmail.com"
        fill_in "Password", with: "test"
        click_button "Log in"

        expect(current_path).to eq("/users/#{@user_2.id}")
      end
    end
  end
end
