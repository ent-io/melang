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
end
