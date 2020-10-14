require 'rails_helper'
#load "#{Rails.root}/db/seeds.rb"
feature 'Key Checkout' do
  scenario 'checking out key' do
    visit access_login_url
    fill_in 'email', with: 'aaustin@email.com'
    fill_in 'password', with: '1234'
    click_button 'Log In'
    expect(page).to have_content('Logged in as')
    sleep(0.1)
    click_link('Checkout/Return Key')
    expect(page).to have_content('Key Checkout/Return')
    click_button 'Checkout Key'
    expect(page).to have_content('You checked out a key!')
    click_link('Checkout/Return Key')
    click_button 'Checkout Key'
    expect(page).to have_content('You already have a key checked out!')
    click_link('Checkout/Return Key')
    click_button 'Return Key'
    expect(page).to have_content('You returned a key!')
    click_link('Checkout/Return Key')
    click_button 'Return Key'
    expect(page).to have_content('You have no key to return!')
  end

  scenario 'admin sees who has keys checked out' do
    visit access_login_url
    fill_in 'email', with: 'aaustin@email.com'
    fill_in 'password', with: '1234'
    click_button 'Log In'
    expect(page).to have_content('Logged in as')
    click_link('Checkout/Return Key')
    click_button 'Checkout Key'
    expect(page).to have_content('You checked out a key!')
    click_link('Logout')
    fill_in 'email', with: 'SWE.InventoryTracker@gmail.com'
    fill_in 'password', with: 'h4gQ4dgHB6mzCK2'
    click_button 'Log In'
    click_link('Manage Users')
    expect(page).to have_content('Yes')
  end
end
    
    


