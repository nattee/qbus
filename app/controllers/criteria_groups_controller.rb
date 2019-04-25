class CriteriaGroupsController < ApplicationController
  before_action :set_criteria_group, only: [:show, :edit, :update, :destroy]
  before_action :admin_authorization

  # GET /criteria_groups
  # GET /criteria_groups.json
  def index
    @criteria_groups = CriteriaGroup.all
  end

  # GET /criteria_groups/1
  # GET /criteria_groups/1.json
  def show
  end

  # GET /criteria_groups/new
  def new
    @criteria_group = CriteriaGroup.new
  end

  # GET /criteria_groups/1/edit
  def edit
  end

  # POST /criteria_groups
  # POST /criteria_groups.json
  def create
    puts criteria_group_params
    @criteria_group = CriteriaGroup.new(criteria_group_params)

    respond_to do |format|
      if @criteria_group.save
        format.html { redirect_to @criteria_group, notice: 'Criteria group was successfully created.' }
        format.json { render :show, status: :created, location: @criteria_group }
      else
        format.html { render :new }
        format.json { render json: @criteria_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criteria_groups/1
  # PATCH/PUT /criteria_groups/1.json
  def update
    respond_to do |format|
      if @criteria_group.update(criteria_group_params)
        format.html { redirect_to @criteria_group, notice: 'Criteria group was successfully updated.' }
        format.json { render :show, status: :ok, location: @criteria_group }
      else
        format.html { render :edit }
        format.json { render json: @criteria_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criteria_groups/1
  # DELETE /criteria_groups/1.json
  def destroy
    @criteria_group.destroy
    respond_to do |format|
      format.html { redirect_to criteria_groups_url, notice: 'Criteria group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criteria_group
      @criteria_group = CriteriaGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criteria_group_params
      params.require(:criteria_group).permit(:name, :group_weight)
    end
end
