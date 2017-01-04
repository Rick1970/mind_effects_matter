class ExperimentsController < ApplicationController
  before_action :set_experiment, only: [:show, :edit, :update, :destroy, :users, :add_user]
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :new, :create, :users, :add_user]
  before_action :verify_tenant

  # GET /experiments
  # GET /experiments.json
  def index
    @experiments = Experiment.by_user_plan_and_tenant(params[:tenant_id], current_user)
  end

  # GET /experiments/1
  # GET /experiments/1.json
  def show
  end

  # GET /experiments/new
  def new
    @experiment = Experiment.new
  end

  # GET /experiments/1/edit
  def edit
  end

  # POST /experiments
  # POST /experiments.json
  def create
    @experiment = Experiment.new(experiment_params)
    @experiment.users << current_user
    respond_to do |format|
      if @experiment.save
        format.html { redirect_to root_url, notice: 'Experiment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /experiments/1
  # PATCH/PUT /experiments/1.json
  def update
    respond_to do |format|
      if @experiment.update(experiment_params)
        format.html { redirect_to root_url, notice: 'Experiment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /experiments/1
  # DELETE /experiments/1.json
  def destroy
    @experiment.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Experiment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def users
    @experiment_users = (@experiment.users + (User.where(tenant_id: @tenant.id, is_admin: true))) - [current_user]
    @other_users = @tenant.users.where(tenant_id: @tenant.id, is_admin: false) - (@experiment_users + [current_user])
  end
  
  def add_user
    @experiment_user = UserExperiment.new(user_id: params[:user_id], experiment_id: @experiment.id)
    
    respond_to do |format|
      if @experiment_user.save
        format.html {redirect_to  users_tenant_experiment_url(id: @experiment.id, tenant_id: @experiment.tenant_id), notice: "User was successfully added to experiment" }
      else
        format.html { redirect_to users_tenant_experiment_url(id: @experiment.id, tenant_id: @experiment.tenant_id), error: "User was not added to experiment." }
      end  
    end  
      
  end  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiment
      @experiment = Experiment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiment_params
      params.require(:experiment).permit(:title, :details, :expected_start_date, :tenant_id)
    end
    
    def set_tenant
      @tenant = Tenant.find(params[:tenant_id])
    end  
    
    def verify_tenant
      unless params[:tenant_id] == Tenant.current_tenant_id.to_s
      redirect_to :root, flash: { error: 'You are not authorized to access any organization other than your own.'}
      end
    end  
end
