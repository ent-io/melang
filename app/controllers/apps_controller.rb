  class AppsController < ApplicationController
  
  # GET /apps
  # GET /apps.json
  def index
    @apps = App.with_role(:owner, current_user)     
    # @apps = App.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    @app = App.find(params[:id])

    # check if user is owner
    check_owner(@app)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @app }
    end
  end

  # GET /apps/new
  # GET /apps/new.json
  def new
    @app = App.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @app }
    end
  end

  # GET /apps/1/edit
  def edit
    @app = App.find(params[:id])
    
    check_owner(@app)
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(params[:app])

    respond_to do |format|
      if @app.save
        assign_owner(@app)

        format.html { redirect_to @app, notice: 'App was successfully created.' }
        format.json { render json: @app, status: :created, location: @app }
      else
        format.html { render action: "new" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apps/1
  # PUT /apps/1.json
  def update
    @app = App.find(params[:id])

    check_owner(@app)

    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app = App.find(params[:id])

    check_owner(@app)

    @app.destroy

    respond_to do |format|
      format.html { redirect_to apps_url }
      format.json { head :no_content }
    end
  end

  
  
  def assign_owner(app)
    current_user.add_role(:owner, app)
   end

  def check_owner(app)
    unless current_user.owner?(app)
      redirect_to apps_path, notice: "You don't have access to that app" && return      
    end
  end

     
end
