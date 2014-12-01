class InterpretationsController < ApplicationController
  before_action :set_interpretation, only: [:show, :edit, :update, :destroy]
  before_action :require_login


  def require_login
      ck = cookies[:admin]
      if ck!=User.find(1).cookie
         render nothing: true, status: :unauthorized
      end
  end

  # GET /interpretations
  # GET /interpretations.json
  def index
    @interpretations = Interpretation.all
  end

  # GET /interpretations/1
  # GET /interpretations/1.json
  def show
  end

  # GET /interpretations/new
  def new
    
     @interpretation = Interpretation.create
     @interpretation.scale_id = params[:scale_id]
     @interpretation.save
     respond_to do |format|
        format.html { } # in the case of disabled JS support
        format.js
    end    
  end

  # GET /interpretations/1/edit
  def edit
  end

  # POST /interpretations
  # POST /interpretations.json
  def create
    @interpretation = Interpretation.new(interpretation_params)

    respond_to do |format|
      if @interpretation.save
        format.html { redirect_to @interpretation, notice: 'Interpretation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @interpretation }
      else
        format.html { render action: 'new' }
        format.json { render json: @interpretation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interpretations/1
  # PATCH/PUT /interpretations/1.json
  def update
    respond_to do |format|
      if @interpretation.update(interpretation_params)
        format.html { redirect_to @interpretation, notice: 'Interpretation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @interpretation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interpretations/1
  # DELETE /interpretations/1.json
  def destroy
    @interpretation.destroy
    respond_to do |format|
      format.html { redirect_to interpretations_url }
      format.json { head :no_content }
    end
  end
def save_all_inters
  params["interpretations"].each() do |(key,value)|
          @interpretation=Interpretation.find(key)
          if(@interpretation!=nil)
            @interpretation.update(value)
          end 
    end
end
def delete_all_inters
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interpretation
      @interpretation = Interpretation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interpretation_params
      params.require(:interpretation).permit(:scale_id, :value_from, :value_to, :text)
    end
end
