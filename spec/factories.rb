FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "title#{n}" }
    sequence(:content) { |n| "content#{n}" }
    is_published true
  end

end