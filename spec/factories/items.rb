FactoryBot.define do
  factory :item do
    name { "Example Item" } 
    description { "This is an example item." }  
    category_id { 2 }  
    item_status_id { 3 } 
    shopping_cost_id { 2 }  
    prefecture_id { 5 }  
    shopping_date_id { 2 } 
    price { 1000 } 
    after(:build) do |item|
      item.image.attach(io: File.open('public/image/output-image1.png'), filename: 'output-image1.png')
    end

    association :user
  end
end
