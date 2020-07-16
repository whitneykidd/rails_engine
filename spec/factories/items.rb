FactoryBot.define do
  factory :item do
    name { Faker::Games::SuperSmashBros.fighter }
    description { Faker::Movie.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant
  end
end
