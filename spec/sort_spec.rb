require 'rails_helper'

feature 'Sorting' do
  before do
      visit access_menu_path
      fill_in 'email', with: 'SWE.InventoryTracker@gmail.com'
      fill_in 'password', with: 'h4gQ4dgHB6mzCK2'
      click_on 'Log In'
  end

  scenario 'sort the inventory by name' do
    click_link 'Manage Items'
    select 'Name', from: 'sort_type'
    select 'A -> Z', from: 'sort_dir'
    click_on 'Sort'
    count = 0
    page.all('td').each do |td|
        if count == 0
            expect(td).to have_content('Apple')
        elsif count == 6
            expect(td).to have_content('Ball')
        elsif count == 12
            expect(td).to have_content('Chair')
        end
        count = count+1
    end

    select 'Name', from: 'sort_type'
    select 'Z -> A', from: 'sort_dir'
    click_on 'Sort'
    count = 0
    page.all('td').each do |td|
        if count == 0
            expect(td).to have_content('Chair')
        elsif count == 6
            expect(td).to have_content('Ball')
        elsif count == 12
            expect(td).to have_content('Apple')
        end
        count = count+1
    end
end

  scenario 'sort the inventory by description' do
    click_link 'Manage Items'
    select 'Description', from: 'sort_type'
    select 'A -> Z', from: 'sort_dir'
    click_on 'Sort'
    count = 0
    page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end

        select 'Description', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort the inventory by total stock' do
        click_link 'Manage Items'
        select 'Total Stock', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end

        select 'Total Stock', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end
    end

    scenario 'sort the inventory by available stock' do
        click_link 'Manage Items'
        select 'Available Stock', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end

        select 'Available Stock', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end
    end

    scenario 'sort the users by first name' do
        click_link 'Manage Users'
        select 'First Name', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        #save_and_open_page
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Alice')
            elsif count == 6
                expect(td).to have_content('Brandon')
            elsif count == 12
                expect(td).to have_content('Chris')
            elsif count == 18
                expect(td).to have_content('SWE')
            end
            count = count+1
        end

        select 'First Name', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('SWE')
            elsif count == 6
                expect(td).to have_content('Chris')
            elsif count == 12
                expect(td).to have_content('Brandon')
            elsif count == 18
                expect(td).to have_content('Alice')
            end
            count = count+1
        end
    end

    scenario 'sort the users by last name' do
        click_link 'Manage Users'
        select 'Last Name', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('SWE')
            elsif count == 6
                expect(td).to have_content('Alice')
            elsif count == 12
                expect(td).to have_content('Brandon')
            elsif count == 18
                expect(td).to have_content('Chris')
            end
            count = count+1
        end

        select 'Last Name', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chris')
            elsif count == 6
                expect(td).to have_content('Brandon')
            elsif count == 12
                expect(td).to have_content('Alice')
            elsif count == 18
                expect(td).to have_content('SWE')
            end
            count = count+1
        end
    end
=begin
    scenario 'sort the users by permissions' do
        click_link 'Manage Users'
        select 'Permissions', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chris')
            elsif count == 6
                expect(td).to have_content('Alice')
            elsif count == 12
                expect(td).to have_content('Brandon')
            elsif count == 18
                expect(td).to have_content('SWE')
            end
            count = count+1
        end

        select 'Permissions', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('SWE')
            elsif count == 6
                expect(td).to have_content('Brandon')
            elsif count == 12
                expect(td).to have_content('Alice')
            elsif count == 18
                expect(td).to have_content('Chris')
            end
            count = count+1
        end
    end

    scenario 'sort the users by amount of checked out items' do
        click_link 'Manage Users'
        select 'Amount of Rented Items', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('SWE')
            elsif count == 6
                expect(td).to have_content('Brandon')
            elsif count == 12
                expect(td).to have_content('Chris')
            elsif count == 18
                expect(td).to have_content('Alice')
            end
            count = count+1
        end

        select 'Amount of Rented Items', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Alice')
            elsif count == 6
                expect(td).to have_content('Chris')
            elsif count == 12
                expect(td).to have_content('Brandon')
            elsif count == 18
                expect(td).to have_content('SWE')
            end
            count = count+1
        end
    end

    scenario 'sort an individual users checkouts by item name' do
        click_link 'View All Checked Out Items'
        #find('td', text: 'Alice').click_link('Show Items')
        select 'Item Name', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end

        select 'Item Name', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort an individual users checkouts by amount' do
        click_link 'View All Checked Out Items'
        select 'Amount', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end

        select 'Amount', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort an individual users checkouts by checkout date' do
        click_link 'View All Checked Out Items'
        select 'Checkout Date', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end

        select 'Checkout Date', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end
    end

    scenario 'sort an individual users checkouts by checkout reason' do
        click_link 'View All Checked Out Items'
        select 'Checkout Reason', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end

        select 'Checkout Reason', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by item name' do
        click_link 'View All Checked Out Items'
        select 'Item Name', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end

        select 'Item Name', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by amount' do
        click_link 'View All Checked Out Items'
        select 'Amount', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end

        select 'Amount', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by person' do
        click_link 'View All Checked Out Items'
        select 'Person', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end

        select 'Person', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by checkout date' do
        click_link 'View All Checked Out Items'
        select 'Checkout Date', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end

        select 'Checkout Date', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by checkout reason' do
        click_link 'View All Checked Out Items'
        select 'Checkout Reason', from: 'sort_type'
        select 'A -> Z', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Apple')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Chair')
            end
            count = count+1
        end

        select 'Checkout Reason', from: 'sort_type'
        select 'Z -> A', from: 'sort_dir'
        click_on 'Sort'
        count = 0
        page.all('td').each do |td|
            if count == 0
                expect(td).to have_content('Chair')
            elsif count == 6
                expect(td).to have_content('Ball')
            elsif count == 12
                expect(td).to have_content('Apple')
            end
            count = count+1
        end
    end
=end
end
