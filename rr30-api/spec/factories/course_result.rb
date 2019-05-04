FactoryBot.define do
  factory :course_result do
    usd { Faker::Number.unique.decimal(1, 4) }
    eur { Faker::Number.unique.decimal(1, 4) }
    rur { Faker::Number.unique.decimal(1, 4) }
    created_at { Time.now }

    factory :course_result_day_ago do
      created_at { Faker::Date.backward(1) }
    end

    factory :course_result_days_ago do
      created_at { Faker::Date.backward(10) }
    end
  end
end
