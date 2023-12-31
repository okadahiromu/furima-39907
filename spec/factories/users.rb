FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.last_name}
    email                 {Faker::Internet.email}
    password              { 'password123A' }
    password_confirmation { 'password123A' }
    last_name             { '田中' }
    first_name            { '太郎' }
    last_name_kana        { 'タナカ' }
    first_name_kana       { 'タロウ' }
    birth_date            { Date.new(1990, 1, 1) }
  end
end