FactoryGirl.define do
  sequence :app_name do |n|
    "app-#{n}"
  end

  factory :app do |n|
    name { FactoryGirl.generate(:app_name) }
    git_url { "http://example.com/#{name}" }
  end
end
