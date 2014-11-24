FactoryGirl.define do
  factory :scene do
    sequence(:title) { |n| "title #{n}" }
    description   "blablabla"
    next_scenes   []
    previous_scenes   []
  end

end
