# coding: utf-8

require 'spec_helper'

feature "Visit Homepage" do

  feature "normal elements in view" do
    scenario "user not sign_in" do
      visit root_path
      within ".navbar" do
        expect(page).to have_link('Project name')
        expect(page).to have_link('Home')
        expect(page).to have_link('About')
        expect(page).to have_link('Contact')
      end
      expect(page).to have_content('Bootstrap')
    end
  end

end
