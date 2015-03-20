# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts '== Creating Admin =='
admin = User.find_by_email 'admin@example.com'
unless admin
  admin = Admin.create!(
      name: 'Admin',
      email: 'admin@example.com',
      password: '123123123'
  )
end

puts '==Creating vendor =='
vendors = Vendor.all
if vendors.count < 50
  (1..100).each do |i|
    Vendor.create(
        name: "Vendor #{i}",
        email: "vendor#{i}@example.com",
        password: '123123123',
        address:  'Somewhere in Singapore',
        description:'The best restaurants, bars and hawkers to eat, drink and be see at. Recipes to try, interviews with food personalities and the latest food news.',
        phone: '6652-3568',
        fax:  '6652-3578',
        picture: '',
        longitude: '103.8492009',
        latitude: '1.3233667',
    )
  end
end

puts '==Creating data vendor =='
vendors = Vendor.all
vendors.each do |vendor|
  DataVendor.create(vendor_id: vendor.id,reward_detail: 'You got a discount of 20% for the foods', reward_image: '')
end
