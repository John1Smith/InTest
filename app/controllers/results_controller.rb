class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
  before_action :require_login


  def require_login
      ck = cookies[:admin]
      if ck!=User.find(1).cookie
         user_cookie = cookies[:user]
         if user_cookie==""
            render nothing: true, status: :unauthorized
         end 
      end
  end

  # GET /results
  # GET /results.json
  def index
      if params[:test] == nil
         @save_user_cookie = "949b40124a47a99856b721982eb8303f9d450887"
         user_cookie = cookies[:user]
         user = User.where(cookie: user_cookie).first
         if user==nil
           redirect_to new_user_path(sc: @save_user_cookie)
         else 
           res  = Result.where(user_id: user.id).select(:test_id).uniq
           test = Test.where.not(id: res).order('order_number').first 
           if test == nil
              redirect_to url_for(:controller => :users, :action => :show_result, user: user.id)
           else   
               @user_id = user.id
               @test_id = test.id

               @results = Result.where(test_id: test.id, user_id: user.id)        
               @result  = Result.new
       
               @test    = Test.find(@test_id)
               @user    = User.find(@user_id) 

               @question = Question.new 
               @questions = Question.where(test_id: test.id)       

           end
         end

      else 


         @user_id = params[:user]!=nil ? params[:user] : '1'
         @test_id = params[:test]
         @results = Result.where(test_id: params[:test], user_id: @user_id)        
         @result  = Result.new
 
         @test    = Test.find(@test_id)
         @user    = User.find(@user_id) 

         @question = Question.new 
         @questions = Question.where(test_id: params[:test])       
      end  
    
  end

  def all_results
    @results = ScaleResult.all.order('user_id')
  end 

  def save_all
      user_id       = params["user_id"]
      test_id       = params["test_id"]
      Result.delete_all(:test_id => test_id, :user_id => user_id)

      if params["question"]!=nil
      i=1
      params["question"].each() do |(key,value)|  
        question_id = key
        answer_id   = value

        result               = Result.new
        result.user_id       = user_id
        result.test_id       = test_id
        result.question_id   = question_id
        result.answer_id     = answer_id
        result.npp           = i
        result.save
        i=i+1
      end   
    end
      next_test_id = Test.all.order('order_number').where('order_number >'+Test.find(test_id).order.to_s).first
      if next_test_id!=nil 
        respond_to do |format|
            format.html { redirect_to results_path(user: user_id, test: next_test_id) }
            format.js   { redirect_to results_path(user: user_id, test:  next_test_id) }          
        end    
      else
        respond_to do |format|
            format.html { redirect_to url_for(:controller => :users, :action => :show_result, user: user_id) }
            format.js   {  redirect_to url_for(:controller => :users, :action => :show_result, user: user_id)}          
        end    
      end  
      


  end



  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Result was successfully created.' }
        format.json { render action: 'show', status: :created, location: @result }
      else
        format.html { render action: 'new' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:user_id, :test_id, :question_id, :answer_id)
    end
end
