FactoryBot.define do
  factory :micropost, class: Micropost do
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    association :user, factory: :user
  end

  # factory :other_micropost, class: Micropost do
  #   title { generate :micropost_title }
  #   content { Faker::Lorem.sentence(5) }
  #   created_at { 42.days.ago }
  #   association :user, factory: :user
  # end

  # sequence :micropost_title do |i|
  #   "micropost_#{i}"
  # end

  trait :orange do
    created_at { 10.minutes.ago }
  end
  trait :tau_manifesto do
    created_at { 3.years.ago }
  end
  trait :cat_video do
    created_at { 2.hours.ago }
  end
  trait :most_recent do
    created_at { Time.zone.now }
  end
end
