FactoryGirl.define do
  factory :player, class: User do
    first_name  "John"
    last_name   "Doe"
    email       "john.doe@gmail.com"
    password    "12345678"
  end
  factory :character, class: User do
    first_name  "John"
    last_name   "Smith"
    email       "john.smith@gmail.com"
    password    "12345678"
    roles       [Role.where(name: "character").first]
  end
  factory :admin, class: User do
    first_name  "Tim"
    last_name   "Monley"
    email       "tim.monley@gmail.com"
    password    "12345678"
    roles       [Role.where(name: "admin").first]
  end
end
