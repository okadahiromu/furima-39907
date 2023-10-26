FactoryBot.define do
  factory :order_buyer do
    post_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    block { '1-1' }
    building { '' }
    phone_number { 12345678987}
    item_id { 1 }
  end
end
