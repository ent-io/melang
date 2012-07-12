# encoding: UTF-8
require 'spec_helper'

describe Bucket do

  context 'ActiveRecord' do
    context 'columns' do
      it { should have_db_column(:id).of_type(:integer).with_options(
        :primary => true,
        :null => false
      ) }
      it { should have_db_column(:name).of_type(:string).with_options(
        :limit => 255,
        :null => false
      ) }
      it { should have_db_column(:app_id).of_type(:integer).with_options(
        :null => false
      ) }
      it { should have_db_column(:created_at).of_type(:datetime).with_options(
        :null => false
      ) }
      it { should have_db_column(:updated_at).of_type(:datetime).with_options(
        :null => false
      ) }
    end

    context 'indices' do
      it { should have_db_index(:name).unique(true) }
      it { should have_db_index(:app_id).unique(true) }
    end

    context 'associations' do
      it { should belong_to(:app) }
    end

    context 'attributes' do
      it { should have_readonly_attribute(:name) }
      it { should have_readonly_attribute(:app_id) }
    end
  end

  context 'ActiveModel' do
    context 'validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:app_id) }

      let!(:bucket) { FactoryGirl.create(:bucket) }
      it { should validate_uniqueness_of(:name) }
      it { should validate_uniqueness_of(:app_id) }
    end
  end

  context '#storage' do
    context 'service exists' do
      let(:bucket) { FactoryGirl.create(:bucket) }
      it { bucket.storage.key.should == bucket.name }
    end
    context 'service does not exist' do
      it 'before save' do
        bucket = FactoryGirl.build(:bucket)
        bucket.storage.should be_nil
      end
      it 'after destroy' do
        bucket = FactoryGirl.create(:bucket)
        bucket.save
        bucket.storage.should_not be_nil
        bucket.send(:delete_bucket)
        bucket.storage.should be_nil
      end
    end
  end
end
