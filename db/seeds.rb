# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: 'SWE', last_name: 'Administrator', email: 'SWE.InventoryTracker@gmail.com', password_digest: BCrypt::Password.create('h4gQ4dgHB6mzCK2'), permissions: 2)

users = User.create([{ first_name: 'Alice', last_name: 'Austin', email: 'aaustin@email.com', password_digest: BCrypt::Password.create('1234'), item_ids: [1,2,3], permissions: 1 }, 
    { first_name: 'Brandon', last_name: 'Barrio', email: 'bbario@email.com', password_digest: BCrypt::Password.create('1234'), permissions: 1}, 
    { first_name: 'Chris', last_name: 'Connor', email: 'cconnor@email.com', password_digest: BCrypt::Password.create('1234') }])

checkouts = Checkout.create([{ user_id: 1, checkout_reason: 'A', amount: 1, item_id: 1 }, 
    { user_id: 1, checkout_reason: 'B', amount: 2, item_id: 2 }, 
    { user_id: 1, checkout_reason: 'C', amount: 3, item_id: 3 }])

items = Item.create([{ name: 'Apple', description: 'Apple', total_stock: 5, avail_stock: 10, location: 'Austin', merch: 'Yes' }, 
    { name: 'Ball', description: 'Ball', total_stock: 4, avail_stock: 8, location: 'Boston', merch: 'Yes' }, 
    { name: 'Chair', description: 'Chair', total_stock: 3, avail_stock: 6, location: 'Colorado', merch: 'Yes' }])

