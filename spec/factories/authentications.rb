# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    user_id 1
    provider "github"
    uid "111030300"
    user_token ""
    repo_token ""
  end
end
