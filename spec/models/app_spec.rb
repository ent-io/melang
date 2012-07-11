require 'spec_helper'

describe App do

  context 'validations' do

    let(:valid_app_name) { FactoryGirl.generate(:app_name) }

    it 'should require a name' do
      app = FactoryGirl.build(:app, :name => nil)
      app.name.should be_blank
      app.should_not be_valid
      app.should have_at_least(1).errors_on(:name)

      app.name = valid_app_name
      app.should be_valid
    end

    it 'should enforce unique names' do
      app = FactoryGirl.create(:app, :name => valid_app_name)
      app.should be_valid

      duplicate_app = FactoryGirl.build(:app, :name => valid_app_name)
      duplicate_app.should_not be_valid
      duplicate_app.should have_at_least(1).errors_on(:name)

      duplicate_app.name = FactoryGirl.generate(:app_name)
      duplicate_app.should be_valid
    end

  end

end
