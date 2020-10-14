require 'rails_helper'

feature 'new user' do
    before do
        visit new_user_path
        fill_in 'user_first_name', with: 'First'
        fill_in 'user_last_name', with: 'Last'
        fill_in 'user_email', with: 'email@email.com'
        fill_in 'user_password', with: 'password'
        click_on 'Submit'
        expect(page).to have_content('Account Created. You will receive an e-mail shortly. Please await authorization before using the site.')
        fill_in 'email', with: 'email@email.com'
        fill_in 'password', with: 'password'
        click_on 'Log In'
    end

    scenario 'registers/logs in and lands on pending authorization page' do
        expect(page).to have_content('Account not yet authorized.')
        expect(page).to have_content('Please wait to be granted access by the administrator.')
    end

    scenario 'registers/logs in and can\'t access other pages besides login/logout/register' do
        visit items_path
        expect(page).to have_no_content('Inventory List')
        expect(page).to have_content('Please wait to be granted access by the administrator.')
        visit checkout_path
        expect(page).to have_no_content('Items Checked Out')
        expect(page).to have_content('Please wait to be granted access by the administrator.')
        visit access_menu_path
        expect(page).to have_content('Please wait to be granted access by the administrator.')
        visit users_path
        expect(page).to have_content('Please wait to be granted access by the administrator.')
        visit new_user_path
        expect(page).to have_content('Fill in the information to register!')
        visit access_logout_path
        expect(page).to have_content('logged out.')
        visit access_login_path
        expect(page).to have_content('Email')
    end

end