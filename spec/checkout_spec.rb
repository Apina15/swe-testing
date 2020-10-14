require 'rails_helper'

feature 'Checkouts' do
    before do
        visit access_login_path
        fill_in 'email', with: 'SWE.InventoryTracker@gmail.com'
        fill_in 'password', with: 'h4gQ4dgHB6mzCK2'
        click_on 'Log In'
        click_link('Manage Items')
        visit new_item_path
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '100'
        fill_in 'item_avail_stock', with: '100'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Add New item'
    end

    scenario 'see recent checkout in show all for none merch items' do
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('Test Merchandise')
        click_link('Checkout')
        fill_in 'checkout_amount', with: '10'
        fill_in 'reason', with: 'Test Checkout Reason'
        click_on 'Submit'
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('90')
        click_link('Back to Main Page')
        expect(page).to have_content('Admin Menu')
        click_link('View All Checked Out Items')
        expect(page).to have_content('Test Checkout Reason')
        expect(page).to have_content('10')
    end

    scenario 'do not see returned checkout on My Items or Show All Checkouts for none merch items' do
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('Test Merchandise')
        click_link('Checkout')
        fill_in 'checkout_amount', with: '10'
        fill_in 'reason', with: 'Test Checkout Reason'
        click_on 'Submit'
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('90')
        click_link('Back to Main Page')
        expect(page).to have_content('Admin Menu')
        click_link('View All Checked Out Items')
        expect(page).to have_content('Test Checkout Reason')
        expect(page).to have_content('10')
        click_link('Back to Main Page')
        click_link('My Checked Out Items')
        expect(page).to have_content('My Items')
        expect(page).to have_content('Test Merchandise')
        expect(page).to have_content('Test Checkout Reason')
        expect(page).to have_content('10')
        click_link('Return')
        expect(page).to have_content('Return Item Form')
        fill_in 'return_amount', with: '10'
        click_on 'Submit'
        expect(page).to have_content('My Items')
        expect(page).to have_no_content('Test Merchandise')
        expect(page).to have_no_content('Test Checkout Reason')
        expect(page).to have_no_content('10')
        click_link('Back to Main Page')
        expect(page).to have_content('Admin Menu')
        click_link('View All Checked Out Items')
        expect(page).to have_no_content('Test Checkout Reason')
        expect(page).to have_no_content('10')
        expect(page).to have_no_content('90')
    end
    
    scenario 'see recent checkout in show all for for merch items' do
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('Test Merchandise')
        click_link('Edit')
        select('Yes', :from=>'item_merch')
        click_on 'Update item'
        click_link('Back to Inventory Page')
        click_link('Checkout')
        fill_in 'checkout_amount', with: '10'
        fill_in 'reason', with: 'Test Checkout Reason'
        click_on 'Submit'
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('90')
        expect(page).to have_no_content('100')
        click_link('Back to Main Page')
        expect(page).to have_content('Admin Menu')
        click_link('View All Checked Out Items')
        expect(page).to have_content('Test Checkout Reason')
        expect(page).to have_content('10')
    end

    scenario 'Returning merch on My Items' do
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('Test Merchandise')
        click_link('Edit')
        select('Yes', :from=>'item_merch')
        click_on 'Update item'
        click_link('Back to Inventory Page')
        click_link('Checkout')
        fill_in 'checkout_amount', with: '10'
        fill_in 'reason', with: 'Test Checkout Reason'
        click_on 'Submit'
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('90')
        expect(page).to have_no_content('100')
        click_link('Back to Main Page')
        expect(page).to have_content('Admin Menu')
        click_link('View All Checked Out Items')
        expect(page).to have_content('Test Checkout Reason')
        expect(page).to have_content('10')
        click_link('Back to Main Page')
        click_link('My Checked Out Items')
        expect(page).to have_content('My Items')
        expect(page).to have_content('Test Merchandise')
        expect(page).to have_content('Test Checkout Reason')
        expect(page).to have_content('10')
        click_link('Return')
        expect(page).to have_content('Return Item Form')
        fill_in 'return_amount', with: '5'
        fill_in 'sold', with: '1'
        click_on 'Submit'
        expect(page).to have_content('My Items')
        expect(page).to have_content('Test Merchandise')
        expect(page).to have_content('Test Checkout Reason')
        expect(page).to have_content('4')
        click_link('Back to Main Page')
        expect(page).to have_content('Admin Menu')
        click_link('View All Checked Out Items')
        expect(page).to have_content('Test Checkout Reason')
        expect(page).to have_content('4')
    end
end
