FactoryBot.define do
  factory :book, class: Book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    good_point { Faker::Lorem.paragraph(sentence_count: 2) }
    association :user, factory: :user
  end

  trait :second_newest do
    created_at { 10.minutes.ago }
  end
  trait :oldest do
    created_at { 3.years.ago }
  end
  trait :second_oldest do
    created_at { 2.hours.ago }
  end
  trait :newest do
    created_at { Time.zone.now }
  end
end
