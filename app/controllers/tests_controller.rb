class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all.order('[order]')
    # Кука для сохранения админской куки 
    # /test/?sac=2b3492c3881d01f050e70b0b7d2f1405f4e192be
    @save_user_cookie = "949b40124a47a99856b721982eb8303f9d450887"
    save_admin_cookie = "2b3492c3881d01f050e70b0b7d2f1405f4e192be"
    if params[:sac] == save_admin_cookie
       user = User.find(1)
       cookies[:admin] = user.cookie
    end
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = Test.new
     render '_form', layout: 'question'
    # respond_to do |format|
      #  format.html { render '_form' }
       # format.js { render '_form'}  
    #end    
    
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)
    respond_to do |format|
      if @test.save
        format.html { redirect_to tests_path, notice: 'Test was successfully created.' }
        format.json { render action: 'show', status: :created, location: @test }
      else
        format.html { render action: 'new' }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to tests_path, notice: 'Test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:name, :description, :order, :test_type)
    end

    def require_login
      ck = cookies[:admin]
      if ck!=User.find(1).cookie
         save_admin_cookie = "2b3492c3881d01f050e70b0b7d2f1405f4e192be"
         if params[:sac] != save_admin_cookie
           render nothing: true, status: :unauthorized
         end  
      end
    end
end
