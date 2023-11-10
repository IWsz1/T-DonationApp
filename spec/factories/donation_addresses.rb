FactoryBot.define do
  factory :donation_address do
    postal_code{"123-4567"}
    prefecture{2}
    city{"東京都"}
    house_number{"1-1"}
    building_name{"テストハイツ"}
    price{2000}
  end
end
