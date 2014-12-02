class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login


  def require_login
      ck = cookies[:admin]
      if ck!=User.find(1).cookie
         user_cookie = cookies[:user]
         if user_cookie==nil
            @save_user_cookie = "949b40124a47a99856b721982eb8303f9d450887"
            if params[:sc] == @save_user_cookie
               ck_user = Digest::SHA1.hexdigest([Time.now, rand].join)    
               cookies[:user] = ck_user
            else
               render nothing: true, status: :unauthorized             
            end    
         end 
      end
  end
  # GET /users
  # GET /users.json
  def index
      ck = cookies[:admin]
      if ck!=User.find(1).cookie
          render nothing: true, status: :unauthorized             
      else    
          @users = User.all        
      end    

  end

  def show_result
      @save_user_cookie = "949b40124a47a99856b721982eb8303f9d450887"
      @user = User.find(params['user']) 

      ScaleResult.delete_all(user_id: @user.id)
      test_ids = Result.where(user_id: @user.id).select(:test_id).distinct
      result_arr=[]
      Result.where(user_id: @user.id).each do |r|
          result_arr << r
      end
      scales = []
      test_ids.each do |t|
        last_question = Question.where(test_id: t.test_id).size
        Scale.where(test_id: t.test_id).each do |s|
            if s.for_user
              qs = (1..last_question).to_a
            else
              qs = s.questions.split(", ")
            end 
            Result.where(user_id: @user.id,test_id: t.test_id, npp: qs).order(:test_id, :question_id, :answer_id).each() do |result|            
              value = Answer.find(result.answer_id).answer_value
              srf = ScaleResult.where(user_id: @user.id, scale_id: s.id)
              if srf.size==0
                sr = ScaleResult.new
                sr.scale_id = s.id
                sr.user_id  = @user.id
                sr.result   = 0
                sr.result   = sr.result + value
                sr.save
              else
                srf[0].result   = srf[0].result + value
                srf[0].save
              end  
            end
        end
      end

      @texts = []
      ScaleResult.where(user_id: @user.id).each do |sr|

        Interpretation.where(scale_id: sr.scale_id).where('? between value_from and value_to',sr.result).each do |intp|
          @texts << intp.text
        end
      end
      
   
  end

  # GET /users/1
  # GET /users/1.json
  def show
    ck = cookies[:admin]
      if ck!=User.find(1).cookie
          render nothing: true, status: :unauthorized             
      end    
  end

  # GET /users/new
  def new
    @user = User.new
    # Кука для генерации и сохранения куки  пользователя
    # /users/new/?sc=949b40124a47a99856b721982eb8303f9d450887    
    @save_user_cookie = "949b40124a47a99856b721982eb8303f9d450887"
    if params[:sc] == @save_user_cookie
       @user.cookie = cookies[:user]
    end    
    

  end

  # GET /users/1/edit
  def edit
    ck = cookies[:admin]
      if ck!=User.find(1).cookie
          render nothing: true, status: :unauthorized             
      end    
  end

  # POST /users
  # POST /users.json
  def create
    user_params.inspect
    @user = User.new(user_params)
    @user.cookie = cookies[:user]
    respond_to do |format|
      if @user.save
        begin_test_id = Test.all.order('order_number').first.id
        format.html { redirect_to results_path(user: @user.id, test: begin_test_id) }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :sex, :age, :work, :profession, :workFunction, :workAge)
    end
end
