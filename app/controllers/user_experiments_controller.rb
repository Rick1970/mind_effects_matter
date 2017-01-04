class UserExperimentsController < ApplicationController
  before_action :set_user_experiment, only: [:show, :edit, :update, :destroy]

  # GET /user_experiments
  # GET /user_experiments.json
  def index
    @user_experiments = UserExperiment.all
  end

  # GET /user_experiments/1
  # GET /user_experiments/1.json
  def show
  end

  # GET /user_experiments/new
  def new
    @user_experiment = UserExperiment.new
  end

  # GET /user_experiments/1/edit
  def edit
  end

  # POST /user_experiments
  # POST /user_experiments.json
  def create
    @user_experiment = UserExperiment.new(user_experiment_params)

    respond_to do |format|
      if @user_experiment.save
        format.html { redirect_to @user_experiment, notice: 'User experiment was successfully created.' }
        format.json { render :show, status: :created, location: @user_experiment }
      else
        format.html { render :new }
        format.json { render json: @user_experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_experiments/1
  # PATCH/PUT /user_experiments/1.json
  def update
    respond_to do |format|
      if @user_experiment.update(user_experiment_params)
        format.html { redirect_to @user_experiment, notice: 'User experiment was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_experiment }
      else
        format.html { render :edit }
        format.json { render json: @user_experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_experiments/1
  # DELETE /user_experiments/1.json
  def destroy
    @user_experiment.destroy
    respond_to do |format|
      format.html { redirect_to users_tenant_experiment_url(id: @user_experiment.experiment_id, tenant_id: @user_experiment.experiment.tenant_id), notice: 'User was successfully removed from the experiment.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_experiment
      @user_experiment = UserExperiment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_experiment_params
      params.require(:user_experiment).permit(:experiment)
    end
end
