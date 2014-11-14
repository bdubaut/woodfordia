FactoryGirl.define do
  factory :scene do
    sequence(:title) { |n| "title #{n}" }
    description   "blablabla"
  end

end
