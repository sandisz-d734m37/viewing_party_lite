require "rails_helper"

describe "welcome page" do
  describe "as a user" do
    describe "when i visit the root path" do
      before do
        @user_1 = User.create!(name: "Tony Soprano", email: "wokeupthismorning@gmail.com", password: 'test', password_confirmation: 'test')
        @user_2 = User.create!(name: "Junior Soprano", email: "varsityathlete@gmail.com", password: 'test', password_confirmation: 'test')
        visit "/"
      end

      it "i see the title of the app" do
        expect(page).to have_content("Welcome to Viewing Party!")
      end

      it "i see a button to create a new user" do
        click_link "Register"
        expect(current_path).to eq("/register")
      end

      it "i see a list of existing users emails, whose names link to their user dashboard" do
        expect(page).not_to have_content("wokeupthismorning@gmail.com")
        expect(page).not_to have_content("varsityathlete@gmail.com")

        click_link("Log in")

        fill_in "Email", with: "varsityathlete@gmail.com"
        fill_in "Password", with: "test"
        click_button "Log in"

        expect(page).not_to have_link("Tony Soprano")
        expect(page).not_to have_link("Junior Soprano")
        expect(page).to have_content("wokeupthismorning@gmail.com")
        expect(page).to have_content("varsityathlete@gmail.com")
      end

      it "i see a link to go back to the landing page" do
        click_link("Return to Home Page")

        expect(current_path).to eq("/")
      end

      it "I see a log in link" do
        expect(page).to have_link("Log in")
        click_link("Log in")
        expect(current_path).to eq("/login")
      end

      context "log in/out" do
        before do
          click_link("Log in")

          fill_in "Email", with: "varsityathlete@gmail.com"
          fill_in "Password", with: "test"
          click_button "Log in"
        end
        it "If I log in, the log in link dissapears" do
          expect(page).not_to have_link("Log in")
          expect(page).to have_link("Log out")
        end

        it "logs you out if you click log out" do
          expect(page).not_to have_link("Log in")
          expect(page).not_to have_link("Register")
          expect(page).to have_link("Log out")
          click_link "Log out"
          expect(page).to have_link("Log in")
          expect(page).to have_link("Register")
          expect(page).not_to have_link("Log out")
        end

        it "'/dashboard' redirects to welcome page if not loggged in" do
          click_link "Log out"

          visit "/dashboard"

          expect(current_path).to eq('/')
          expect(page).to have_content('You must log in or register to visit the dashboard')
        end
      end

    end
  end
end
