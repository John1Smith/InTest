class ScaleResultsController < ApplicationController
  before_action :set_scale_result, only: [:show, :edit, :update, :destroy]
  before_action :require_login


  def require_login
      ck = cookies[:admin]
      if ck!=User.find(1).cookie
         render nothing: true, status: :unauthorized
      end
  end
  # GET /scale_results
  # GET /scale_results.json
  def index
    @scale_results = ScaleResult.all
  end

  # GET /scale_results/1
  # GET /scale_results/1.json
  def show
  end

  # GET /scale_results/new
  def new
    @scale_result = ScaleResult.new
  end

  # GET /scale_results/1/edit
  def edit
  end

  # POST /scale_results
  # POST /scale_results.json
  def create
    @scale_result = ScaleResult.new(scale_result_params)

    respond_to do |format|
      if @scale_result.save
        format.html { redirect_to @scale_result, notice: 'Scale result was successfully created.' }
        format.json { render action: 'show', status: :created, location: @scale_result }
      else
        format.html { render action: 'new' }
        format.json { render json: @scale_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scale_results/1
  # PATCH/PUT /scale_results/1.json
  def update
    respond_to do |format|
      if @scale_result.update(scale_result_params)
        format.html { redirect_to @scale_result, notice: 'Scale result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scale_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scale_results/1
  # DELETE /scale_results/1.json
  def destroy
    @scale_result.destroy
    respond_to do |format|
      format.html { redirect_to scale_results_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scale_result
      @scale_result = ScaleResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scale_result_params
      params.require(:scale_result).permit(:scale_id, :user_id, :result)
    end
end
