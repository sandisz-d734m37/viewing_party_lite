require "rails_helper"

describe "user new page" do
  describe "as a user" do
    describe "when i visit the /register path" do
      before do
        @user_1 = User.create!(name: "Tony Soprano", email: "wokeupthismorning@gmail.com", password: 'test', password_confirmation: 'test')
      end

      it "i see a form to register, including name and email" do
        visit "/register"

        fill_in "Name", with: "Junior Soprano"
        fill_in "Email", with: "varsityathlete@gmail.com"
        fill_in "Password", with: "test_password"
        fill_in "Confirm Password", with: "test_password"

        click_button "Register"

        expect(page).to have_content("Junior Soprano's page")
        expect(page).not_to have_content("Tony Soprano's page")
      end

      it "If I fail to confirm my password I see an error" do
        visit "/register"

        fill_in "Name", with: "Junior Soprano"
        fill_in "Email", with: "varsityathlete@gmail.com"
        fill_in "Password", with: "test_password"
        fill_in "Confirm Password", with: "wrong"

        click_button "Register"

        expect(page).to have_content("Error message")
        expect(page).not_to have_content("Junior Soprano's page")
      end

      it "the form will not accept an email that already exists for some other user in the database" do
        visit "/register"

        fill_in "Name", with: "Junior Soprano"
        fill_in "Email", with: "wokeupthismorning@gmail.com"
        fill_in "Password", with: "test_password"
        fill_in "Confirm Password", with: "test_password"

        click_button "Register"

        expect(page).to have_content("There is already an account associated with this e-mail address.")
      end
    end
  end
end
