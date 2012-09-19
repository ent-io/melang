require 'spec_helper'

describe AppsController do
	describe 'authenticated user' do
		login_user

		before(:each) do 
			@app = FactoryGirl.build(:app)
		end

		describe 'get INDEX' do
			it 'should be successful' do
				get :index
				response.should be_successful
			end
		end
		
		describe 'get NEW' do
			it 'should be successful'	do
				get :new
				response.should be_successful
			end
		end

		describe 'post CREATE' do
			it 'should be successful' do
				post :create, app: { name: @app[:name], git_url: @app[:git_url] }

				App.all.count.should be(1)
				App.first.has_owner?.should be_true
			end
		end

		describe 'get EDIT' do 
			it 'should be successful' do
				post :create, app: { name: @app[:name], git_url: @app[:git_url] }
				app = App.first
				get :edit, id: app.id
				response.should be_successful
			end
		end

		describe 'put EDIT' do
			it 'should be successful' do
				post :create, app: { name: @app[:name], git_url: @app[:git_url] }
				
				app = App.last
				app.has_owner?.should be_true

				new_app_name = 'app-1000'
				put :update, id: app.id, app: { name: new_app_name }

				updated_app = App.find(app.id)
				updated_app.name.should eq(new_app_name)
			end
		end

		describe 'delete DESTROY' do
			it 'should be successful' do
				post :create, app: { name: @app[:name], git_url: @app[:git_url] }
				
				app = App.last
				delete :destroy, id: app.id
				
				App.all.count.should be(0)
			end
		end
	end  # authenticated user

	describe 'UN-authenticated user' do
		describe 'get INDEX' do
			it 'should not be successful' do
				get :index
				response.should_not be_successful
			end
		end
	end  # UN-authenticated

	
end