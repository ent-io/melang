# encoding: UTF-8
require 'spec_helper'

describe App do

  context 'ActiveRecord' do
    context 'columns' do
      it { should
        have_db_column(:id).
        of_type(:integer).
        with_options(:primary => true, :null => false)
      }
      it { should
        have_db_column(:name).
        of_type(:string).
        with_options(:limit => 63, :null => false)
      }
      it { should
        have_db_column(:git_url).
        of_type(:string).
        with_options(:null => false)
      }
      it { should
        have_db_column(:created_at).
        of_type(:datetime).
        with_options(:null => false)
      }
      it { should
        have_db_column(:updated_at).
        of_type(:datetime).
        with_options(:null => false)
      }
    end

    context 'indices' do
      it { should have_db_index(:name).unique(true) }
    end

    context 'associations' do
      it { should have_one(:bucket).dependent(:destroy) }
    end

    context 'attributes' do
      it { should have_readonly_attribute(:name) }
    end
  end

  context 'ActiveModel' do
    context 'validations' do
      it { should validate_presence_of(:name) }

      let!(:app) { FactoryGirl.create(:app) }
      it { should validate_uniqueness_of(:name) }
    end
  end

  # App names must conform to dns conventions so they can be used as subdomains
  # eg. app-name.ent.io
  #
  # see https://developers.google.com/storage/docs/bucketnaming
  context '#name' do
    context 'must be 3 to 63 characters' do
      def str(length)
        length.times.map{'a'}.join
      end
      it { should_not allow_value(str 2).for(:name) }
      it { should allow_value(str 3).for(:name) }
      it { should allow_value(str 63).for(:name) }
      it { should_not allow_value(str 64).for(:name) }
    end

    context 'contains only lowercase letters, numbers, and dashes' do
      it { should allow_value('abc').for(:name) }
      it { should allow_value('abc-123').for(:name) }
      it { should_not allow_value('192-168-5-4').for(:name) }
    end

    context 'contains dots' do
      it { should_not allow_value('abc.123').for(:name) }
    end

    context 'contains underscores' do
      it { should_not allow_value('abc_123').for(:name) }
    end

    context 'contains adjacent dashes' do
      it { should_not allow_value('abc--123').for(:name) }
    end

    context 'contains UTF-8 characters' do
      it { should_not allow_value('El-niño').for(:name) }
    end

    context 'evaluates to an integer' do
      it { should_not allow_value('123').for(:name) }
      it { should_not allow_value('99-bottles-of-beer').for(:name) }
    end

    context 'begins with a forbidden prefix' do
      it { should_not allow_value('-abc123').for(:name) }

      # names that begin with `goog` are forbidden by Google Cloud Storage
      pending 'such as `goog`' do
        should_not allow_value('google').for(:name)
      end
    end
    context 'ends with a forbidden postfix' do
      it { should_not allow_value('abc123-').for(:name) }
    end
  end
end
