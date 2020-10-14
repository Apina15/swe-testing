require 'rails_helper'

feature 'go to items' do
    before do
        visit access_login_path
        fill_in 'email', with: 'SWE.InventoryTracker@gmail.com'
        fill_in 'password', with: 'h4gQ4dgHB6mzCK2'
        click_on 'Log In'
        visit items_path
    end

    scenario 'shows items page' do
        expect(page).to have_content('Inventory List')
    end
end

feature 'Create item' do
    before do
        visit access_login_path
        fill_in 'email', with: 'SWE.InventoryTracker@gmail.com'
        fill_in 'password', with: 'h4gQ4dgHB6mzCK2'
        click_on 'Log In'
        visit new_item_path
    end
    
    scenario 'valid inputs' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '100'
        fill_in 'item_avail_stock', with: '80'
        fill_in 'item_location', with: 'Storage Unit'
        select('Yes', :from=>'item_merch')
        click_on 'Add New item'
        expect(page).to have_content('Inventory List')
        expect(page).to have_content('Yes')
        expect(page).to have_content('Test Merchandise')
    end

    scenario 'blank inputs' do
        click_on 'Add New item'
        expect(page).to have_content('cannot be blank')
    end

    scenario 'negative total stock' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '-10'
        fill_in 'item_avail_stock', with: '0'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Add New item'
        expect(page).to have_content('Total stock must be nonnegative')
    end

    scenario 'negative avail stock' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '0'
        fill_in 'item_avail_stock', with: '-1'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Add New item'
        expect(page).to have_content('Avail stock must be nonnegative')
    end

    scenario 'total stock < avail stock' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '11'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Add New item'
        expect(page).to have_content('must be less than total stock')
    end

    scenario 'stock not an integer' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '1.0'
        fill_in 'item_avail_stock', with: '1.0'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Add New item'
        expect(page).to have_content('must be an integer')
    end

    scenario 'name more than max characters' do
        fill_in 'item_name', with: 'Test Merchandise Test Merchandise Test Merchandise Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '10'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Add New item'
        expect(page).to have_content('Name is more than the maximum allowed')
    end

    scenario 'name more than max characters' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise Test organization merchandise Test organization merchandise Test organization merchandise Test organization merchandise Test organization merchandise Test organization merchandise'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '10'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Add New item'
        expect(page).to have_content('Description is more than the maximum allowed')
    end

    scenario 'location more than max characters' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '10'
        fill_in 'item_location', with: 'Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit'
        click_on 'Add New item'
        expect(page).to have_content('Location is more than the maximum allowed')
    end    
end

feature 'Update item' do
    before do
        visit access_login_path
        fill_in 'email', with: 'SWE.InventoryTracker@gmail.com'
        fill_in 'password', with: 'h4gQ4dgHB6mzCK2'
        click_on 'Log In'
        visit new_item_path
        fill_in 'item_name', with: 'item name'
        fill_in 'item_description', with: 'item description'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '0'
        fill_in 'item_location', with: 'item location'
        select('Yes', :from=>'item_merch')
        click_on 'Add New item'
        click_link('Edit')
    end

    scenario 'change each input to valid input' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '100'
        fill_in 'item_avail_stock', with: '80'
        fill_in 'item_location', with: 'Storage Unit'
        select('No', :from=>'item_merch')
        click_on 'Update item'
        expect(page).to have_content('updated successfully.')
        expect(page).to have_content('Test Merchandise')
        expect(page).to have_content('Test organization merchandise')
        expect(page).to have_content('100')
        expect(page).to have_content('80')
        expect(page).to have_content('No')
        expect(page).to have_content('Storage Unit')
    end

    scenario 'blank inputs' do
        fill_in 'item_name', with: ''
        fill_in 'item_description', with: ''
        fill_in 'item_total_stock', with: ''
        fill_in 'item_avail_stock', with: ''
        fill_in 'item_location', with: ''
        click_on 'Update item'
        expect(page).to have_content('cannot be blank')
    end

    scenario 'negative total stock' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '-10'
        fill_in 'item_avail_stock', with: '0'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Update item'
        expect(page).to have_content('Total stock must be nonnegative')
    end

    scenario 'negative avail stock' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '0'
        fill_in 'item_avail_stock', with: '-1'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Update item'
        expect(page).to have_content('Avail stock must be nonnegative')
    end

    scenario 'total stock < avail stock' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '11'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Update item'
        expect(page).to have_content('must be less than total stock')
    end

    scenario 'stock not an integer' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '1.0'
        fill_in 'item_avail_stock', with: '1.0'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Update item'
        expect(page).to have_content('must be an integer')
    end

    scenario 'name more than max characters' do
        fill_in 'item_name', with: 'Test Merchandise Test Merchandise Test Merchandise Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '10'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Update item'
        expect(page).to have_content('Name is more than the maximum allowed')
    end

    scenario 'name more than max characters' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise Test organization merchandise Test organization merchandise Test organization merchandise Test organization merchandise Test organization merchandise Test organization merchandise'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '10'
        fill_in 'item_location', with: 'Storage Unit'
        click_on 'Update item'
        expect(page).to have_content('Description is more than the maximum allowed')
    end

    scenario 'location more than max characters' do
        fill_in 'item_name', with: 'Test Merchandise'
        fill_in 'item_description', with: 'Test organization merchandise'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '10'
        fill_in 'item_location', with: 'Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit Storage Unit'
        click_on 'Update item'
        expect(page).to have_content('Location is more than the maximum allowed')
    end    
end

feature 'Show item' do
    before do
        visit access_login_path
        fill_in 'email', with: 'SWE.InventoryTracker@gmail.com'
        fill_in 'password', with: 'h4gQ4dgHB6mzCK2'
        click_on 'Log In'
        visit new_item_path
        fill_in 'item_name', with: 'item name'
        fill_in 'item_description', with: 'item description'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '0'
        fill_in 'item_location', with: 'item location'
        select('Yes', :from=>'item_merch')
        click_on 'Add New item'
    end

    scenario 'show correct values' do
        click_link('Details')
        expect(page).to have_content('Item Info')
        expect(page).to have_content('item name')
        expect(page).to have_content('item description')
        expect(page).to have_content('10')
        expect(page).to have_content('0')
        expect(page).to have_content('Yes')
        expect(page).to have_content('item location')
    end
end

feature 'Destroy item' do
    before do
        visit access_login_path
        fill_in 'email', with: 'SWE.InventoryTracker@gmail.com'
        fill_in 'password', with: 'h4gQ4dgHB6mzCK2'
        click_on 'Log In'
        visit new_item_path
        fill_in 'item_name', with: 'item name'
        fill_in 'item_description', with: 'unique item description'
        fill_in 'item_total_stock', with: '10'
        fill_in 'item_avail_stock', with: '0'
        fill_in 'item_location', with: 'item location'
        click_on 'Add New item'
    end

    scenario 'destroy item' do
        click_link('Delete')
        expect(page).to have_content('Are you sure you want to delete this item?')
        expect(page).to have_content('item name')
        click_on 'Delete item'
        expect(page).to have_content('item name')
        expect(page).to have_content('destroyed successfully.')
        expect(page).to have_content('Inventory List')
        expect(page).to have_no_content('unique item description')
    end
end
