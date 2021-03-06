FactoryGirl.define do
  sequence(:position)

  factory :user do
    email 'user@example.com'
    password 'password'
    password_confirmation 'password'

    trait :is_admin do
      role 'admin'
    end

    trait :is_instructor do
      role 'instructor'
    end

    trait :is_creator do
      role 'creator'
    end

    trait :is_student do
      role 'student'
    end

    factory :admin_user, traits: [:is_admin]
  end

  factory :course do
    title "Title of Course"

    factory :course_with_units do
      ignore do
        units_count 5
      end

      after(:create) do |course, evaluator|
        FactoryGirl.create_list(:unit, evaluator.units_count, course: course)
      end
    end
  end

  factory :unit do
    title "Title of Unit"

    course

    factory :unit_with_drills do
      ignore do
        drills_count 5
      end

      after(:create) do |unit, evaluator|
        FactoryGirl.create_list(:drill, evaluator.drills_count, unit: unit)
      end
    end
  end

  factory :drill do
    title "Title of Drill"

    unit

    trait :untitled do
      title nil
    end

    trait :five_childed do
      ignore do
        exercises_count 5
      end

      after(:create) do |grid_drill, evaluator|
        FactoryGirl.create_list(:exercise, evaluator.exercises_count, drill: grid_drill)
      end
    end
 
    factory :untitled_drill, traits: [:untitled]
    factory :five_childed_drill, traits: [:five_childed]
 
    factory :fill_drill, :class => "FillDrill", :parent => :drill do
      title "Title of Fill Drill"
      type "FillDrill"

      trait :five_exercised do
        ignore do
          exercises_count 5
        end

        after(:create) do |fill_drill, evaluator|
          FactoryGirl.create_list(:exercise, evaluator.exercises_count, drill: fill_drill)
        end
      end
      factory :five_exercised_fill_drill, traits: [:five_exercised]
    end

    factory :grid_drill, :class => "GridDrill", :parent => :drill do
      title "Title of Grid Drill"
      type "GridDrill"

      trait :five_headered do
        ignore do
          headers_count 5
        end

        after(:create) do |grid_drill, evaluator|
          FactoryGirl.create_list(:header, evaluator.headers_count, drill: grid_drill)
        end
      end

      trait :five_exercised do
        ignore do
          exercises_count 5
        end

        after(:create) do |grid_drill, evaluator|
          FactoryGirl.create_list(:exercise, evaluator.exercises_count, drill: grid_drill)
        end
      end
      
      trait :five_exercise_itemed_five_exercised do
        ignore do
          exercises_count 5
        end

        after(:create) do |grid_drill, evaluator|
          FactoryGirl.create_list(:five_childed_exercise, evaluator.exercises_count, drill: grid_drill)
        end
      end

      factory :twenty_five_grand_childed_grid_drill, traits: [:five_exercise_itemed_five_exercised]
      factory :five_exercised_grid_drill, traits: [:five_exercised]
      factory :five_headered_grid_drill, traits: [:five_headered]
      # this next one isn't used yet
      factory :five_headered_five_exercised_grid_drill, traits: [:five_headered, :five_exercised]
    end
  end

  factory :exercise do
    title "Title of Exercise"
    prompt "Prompt of Exercise"

    drill

    trait :untitled do
      title nil
    end

    trait :three_correct_responses do
      prompt "Acceptable answers are [many/a few/quite a few]"

      ignore do
        exercise_item_count 1
      end

      after(:create) do |exercise, evaluator|
        FactoryGirl.create_list(:three_correct_responses_exercise_item,evaluator.exercise_item_count,exercise: exercise)
      end
    end

    trait :three_incorrect_responses do
      prompt "Acceptable answers are [many/a few/quite a few]"

      ignore do
        exercise_item_count 1
      end

      after(:create) do |exercise, evaluator|
        FactoryGirl.create_list(:three_incorrect_responses_exercise_item,evaluator.exercise_item_count,exercise: exercise)
      end
    end

    trait :unprompted do
      prompt nil
    end

    trait :five_siblinged do
      association :drill, factory: :five_childed_drill
    end

    trait :five_headered_children do
      ignore do
        exercise_items_count 5
      end

      after(:create) do |exercise, evaluator|
        FactoryGirl.create_list(:headered_exercise_item, evaluator.exercise_items_count, exercise: exercise)
      end
    end

    trait :five_childed do
      ignore do
        exercise_items_count 5
      end

      after(:create) do |exercise, evaluator|
        FactoryGirl.create_list(:exercise_item, evaluator.exercise_items_count, exercise: exercise)
      end
    end

    factory :three_incorrect_responses_exercise, traits: [:three_incorrect_responses]
    factory :three_correct_responses_exercise, traits: [:three_correct_responses]
    factory :five_siblinged_exercise, traits: [:five_siblinged]
    factory :five_headered_children_exercise, traits: [:five_headered_children]
    factory :five_childed_exercise, traits: [:five_childed]
    factory :untitled_exercise, traits: [:untitled]
    factory :unprompted_exercise, traits: [:unprompted]
    factory :empty_exercise, traits: [:untitled, :unprompted]

  end
  
  factory :exercise_item do
    exercise

    trait :default do
      type "Type Defined"
    end

    trait :three_correct_responses do
      acceptable_answers ["many", "a few", "quite a few"]

      ignore do
        response_count 1
      end

      after(:create) do |exercise_item, evaluator|
        FactoryGirl.create_list(:first_correct_response, evaluator.response_count, exercise_item: exercise_item)
        FactoryGirl.create_list(:second_correct_response, evaluator.response_count, exercise_item: exercise_item)
        FactoryGirl.create_list(:third_correct_response, evaluator.response_count, exercise_item: exercise_item)
      end
    end

    trait :three_incorrect_responses do
      acceptable_answers ["many", "a few", "quite a few"]

      ignore do
        response_count 1
      end

      after(:create) do |exercise_item, evaluator|
        FactoryGirl.create_list(:first_incorrect_response, evaluator.response_count, exercise_item: exercise_item)
        FactoryGirl.create_list(:second_incorrect_response, evaluator.response_count, exercise_item: exercise_item)
        FactoryGirl.create_list(:third_incorrect_response, evaluator.response_count, exercise_item: exercise_item)
      end
    end

    trait :unexercised do
      exercise nil
    end

    trait :headered do
      association :header, :factory => [:titled_header]
    end

    trait :five_siblinged do
      association :exercise, factory: :five_childed_exercise
    end

    trait :five_headered_siblinged do
      association :exercise, factory: :five_headered_children_exercise
    end

    trait :typed do
      type "Type Defined"
    end

    factory :three_incorrect_responses_exercise_item, traits: [:three_incorrect_responses]
    factory :three_correct_responses_exercise_item, traits: [:three_correct_responses]
    factory :typed_exercise_item, traits: [:typed]
    factory :headered_exercise_item, traits: [:headered]
    factory :five_siblinged_exercise_item, traits: [:five_siblinged]
    factory :five_siblinged_headered_exercise_item, traits: [:five_siblinged, :headered]
    factory :five_headered_siblinged_headered_exercise_item, traits: [:five_headered_siblinged, :headered]
  end

  factory :response do
    value "typical response"

    exercise_item

    trait :first_incorrect do
      value "man"
    end

    trait :second_incorrect do
      value "any"
    end

    trait :third_incorrect do
      value "m any"
    end

    trait :first_correct do
      value "many"
    end

    trait :second_correct do
      value "a few"
    end

    trait :third_correct do
      value "quite a few"
    end

    factory :first_incorrect_response, traits: [:first_incorrect]
    factory :second_incorrect_response, traits:[:second_incorrect]
    factory :third_incorrect_response, traits: [:third_incorrect]
    factory :first_correct_response, traits: [:first_correct]
    factory :second_correct_response, traits:[:second_correct]
    factory :third_correct_response, traits: [:third_correct]
  end

  factory :header do
    grid_drill

    trait :drillless do
      grid_drill nil
    end

    trait :first do
      position 1
    end

    trait :titled do
      title "Title Defined"
    end

    trait :five_siblinged do
      association :drill, factory: :five_headered_grid_drill
    end

    factory :five_siblinged_header, traits: [:five_siblinged]
    factory :drillless_header, traits: [:drillless]
    factory :titled_header, traits: [:titled]
  end
end