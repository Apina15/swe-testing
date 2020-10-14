require 'rails_helper'

feature 'Sorting' do
    before do
        visit access_menu_path
        fill_in 'email', with: 'bbario@email.com'
        fill_in 'password', with: '1234'
        click_on 'Log In'
    end

    scenario 'sort the inventory by name' do
        click_on 'Manage Items'
        Select 'Name', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Chair')
            end
            count = count+1
        end
        
        Select 'Name', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chair')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort the inventory by description' do
        Select 'Description', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Chair')
            end
            count = count+1
        end
        
        Select 'Description', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chair')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort the inventory by total stock' do
        Select 'Total Stock', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chair')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
        
        Select 'Total Stock', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Chair')
            end
            count = count+1
        end
    end

    scenario 'sort the inventory by available stock' do
        Select 'Available Stock', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chair')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
        
        Select 'Available Stock', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Chair')
            end
            count = count+1
        end
    end

    scenario 'sort the users by first name' do
        visit users_index_path
        Select 'First Name', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Alice')
            elsif count == 1
                expect(tr).to have_content('Brandon')
            elsif count == 2
                expect(tr).to have_content('Chris')
            end
            count = count+1
        end
        
        Select 'First Name', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chris')
            elsif count == 1
                expect(tr).to have_content('Brandon')
            elsif count == 2
                expect(tr).to have_content('Alice')
            end
            count = count+1
        end
    end

    scenario 'sort the users by last name' do
        Select 'Last Name', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Alice')
            elsif count == 1
                expect(tr).to have_content('Brandon')
            elsif count == 2
                expect(tr).to have_content('Chris')
            end
            count = count+1
        end
        
        Select 'Last Name', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chris')
            elsif count == 1
                expect(tr).to have_content('Brandon')
            elsif count == 2
                expect(tr).to have_content('Alice')
            end
            count = count+1
        end
    end

    scenario 'sort the users by permissions' do
        Select 'Permissions', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Alice')
            elsif count == 1
                expect(tr).to have_content('Chris')
            elsif count == 2
                expect(tr).to have_content('Brandon')
            end
            count = count+1
        end
        
        Select 'Permissions', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Brandon')
            elsif count == 1
                expect(tr).to have_content('Chris')
            elsif count == 2
                expect(tr).to have_content('Alice')
            end
            count = count+1
        end
    end

    scenario 'sort the users by amount of checked out items' do
        Select 'Amount of Rented Items', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Brandon')
            elsif count == 1
                expect(tr).to have_content('Chris')
            elsif count == 2
                expect(tr).to have_content('Alice')
            end
            count = count+1
        end
        
        Select 'Amount of Rented Items', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Alice')
            elsif count == 1
                expect(tr).to have_content('Chris')
            elsif count == 2
                expect(tr).to have_content('Brandon')
            end
            count = count+1
        end
    end

    scenario 'sort an individual users checkouts by item name' do
        find('tr', text: 'Alice').click_link('Show Items')
        Select 'Item Name', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Chair')
            end
            count = count+1
        end
        
        Select 'Item Name', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chair')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort an individual users checkouts by amount' do
        Select 'Amount', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Ball')
            elsif count == 1
                expect(tr).to have_content('Chair')
            elsif count == 2
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
        
        Select 'Amount', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Chair')
            elsif count == 2
                expect(tr).to have_content('Ball')
            end
            count = count+1
        end
    end

    scenario 'sort an individual users checkouts by checkout date' do
        Select 'Checkout Date', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Ball')
            elsif count == 1
                expect(tr).to have_content('Chair')
            elsif count == 2
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
        
        Select 'Checkout Date', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Chair')
            elsif count == 2
                expect(tr).to have_content('Ball')
            end
            count = count+1
        end
    end

    scenario 'sort an individual users checkouts by checkout reason' do
        Select 'Checkout Reason', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Chair')
            end
            count = count+1
        end
        
        Select 'Checkout Reason', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chair')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by item name' do
        visit checkouts_showAll_path
        Select 'Item Name', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Apple')
            elsif count == 2
                expect(tr).to have_content('Ball')
            elsif count == 3
                expect(tr).to have_content('Ball')
            elsif count == 4
                expect(tr).to have_content('Chair')
            end
            count = count+1
        end
        
        Select 'Item Name', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chair')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Ball')
            elsif count == 3
                expect(tr).to have_content('Apple')
            elsif count == 4
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by amount' do
        Select 'Amount', From: 'sort_type'
        Select 'A -> Z', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Ball')
            elsif count == 1
                expect(tr).to have_content('Chair')
            elsif count == 2
                expect(tr).to have_content('Ball')
            elsif count == 3
                expect(tr).to have_content('Apple')
            elsif count == 4
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
        
        Select 'Amount', From: 'sort_type'
        Select 'Z -> A', From: 'sort_dir'
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Apple')
            elsif count == 2
                expect(tr).to have_content('Ball')
            elsif count == 3
                expect(tr).to have_content('Chair')
            elsif count == 4
                expect(tr).to have_content('Ball')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by person' do
        #click the two drop downs
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Ball')
            elsif count == 1
                expect(tr).to have_content('Chair')
            elsif count == 2
                expect(tr).to have_content('Apple')
            elsif count == 3
                expect(tr).to have_content('Apple')
            elsif count == 4
                expect(tr).to have_content('Ball')
            end
            count = count+1
        end
        
        #click the two drop downs
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Ball')
            elsif count == 1
                expect(tr).to have_content('Apple')
            elsif count == 2
                expect(tr).to have_content('Apple')
            elsif count == 3
                expect(tr).to have_content('Chair')
            elsif count == 4
                expect(tr).to have_content('Ball')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by checkout date' do
        #click the two drop downs
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Ball')
            elsif count == 1
                expect(tr).to have_content('Chair')
            elsif count == 2
                expect(tr).to have_content('Ball')
            elsif count == 3
                expect(tr).to have_content('Apple')
            elsif count == 4
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
        
        #click the two drop downs
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Apple')
            elsif count == 2
                expect(tr).to have_content('Ball')
            elsif count == 3
                expect(tr).to have_content('Chair')
            elsif count == 4
                expect(tr).to have_content('Ball')
            end
            count = count+1
        end
    end

    scenario 'sort all the checkouts by checkout reason' do
        #click the two drop downs
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Apple')
            elsif count == 1
                expect(tr).to have_content('Apple')
            elsif count == 2
                expect(tr).to have_content('Ball')
            elsif count == 3
                expect(tr).to have_content('Ball')
            elsif count == 4
                expect(tr).to have_content('Chair')
            end
            count = count+1
        end
        
        #click the two drop downs
        click_on 'Search'
        count = 0
        page.all('tr').each do |tr|
            if count == 0
                expect(tr).to have_content('Chair')
            elsif count == 1
                expect(tr).to have_content('Ball')
            elsif count == 2
                expect(tr).to have_content('Ball')
            elsif count == 3
                expect(tr).to have_content('Apple')
            elsif count == 4
                expect(tr).to have_content('Apple')
            end
            count = count+1
        end
    end
end