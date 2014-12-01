class ScalesController < ApplicationController
  before_action :set_scale, only: [:show, :edit, :update, :destroy]
  before_action :require_login


  def require_login
      ck = cookies[:admin]
      if ck!=User.find(1).cookie
         render nothing: true, status: :unauthorized
      end
  end
  # GET /scales
  # GET /scales.json
  def index
    if params[:test] == nil
        @scales = Scale.all
    else
        @test_id   = params[:test]
        @test      = Test.find(@test_id)
        @scales = Scale.where(test_id: params[:test])       
        @scale  = Scale.new
        @scale_for_user = @test.scales.where(for_user: 't')
        @scale_for_user_id= @scale_for_user[0].id if @scale_for_user[0]!=nil 
        @interpretations = Interpretation.where(scale_id: @scale_for_user)       
        @interpretation  = Interpretation.new 

        

        @test_name = @test.name
    end
  end

  # GET /scales/1
  # GET /scales/1.json
  def show
  end

  # GET /scales/new
  def new
     @scale = Scale.create
     @scale.test_id = params[:test_id]
     @scale.save
     respond_to do |format|
        format.html { } # in the case of disabled JS support
        format.js
    end    
  end

  # GET /scales/1/edit
  def edit
  end

  # POST /scales
  # POST /scales.json
  def create
    @scale = Scale.new(scale_params)

    respond_to do |format|
      if @scale.save
        format.html { redirect_to @scale, notice: 'Scale was successfully created.' }
        format.json { render action: 'show', status: :created, location: @scale }
      else
        format.html { render action: 'new' }
        format.json { render json: @scale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scales/1
  # PATCH/PUT /scales/1.json
  def update
    respond_to do |format|
      if @scale.update(scale_params)
        format.html { redirect_to @scale, notice: 'Scale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scales/1
  # DELETE /scales/1.json
  def destroy
    @scale.destroy
    respond_to do |format|
      format.html { redirect_to scales_url }
      format.json { head :no_content }
      format.js { head :no_content }      
    end
  end


  def delete_all
    @test_id = params["test_id"]
    Scale.delete_all(:test_id => @test_id)
    respond_to do |format|
          format.html { }
          format.js { head :no_content }
      end   

  end

  def save_all
    params["scales"].each() do |(key,value)|
          @scale=Scale.find(key)
          if(@scale!=nil)
            @scale.update(value)
          end 
          if @scale.for_user='t'
             @scale_for_user_id=@scale.id
          end  
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scale
      @scale = Scale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scale_params
      params.require(:scale).permit(:test_id, :name, :questions, :result, :for_user)
    end
end
