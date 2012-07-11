FactoryGirl.define do
  factory :bucket do
    app  {|bucket| bucket.association(:app) }
    name {|bucket| bucket.app.to_dns }
  end
end
