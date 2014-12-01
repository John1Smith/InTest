class QuestionsController < ApplicationController

  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :require_login


  def require_login
      ck = cookies[:admin]
      if ck!=User.find(1).cookie
         render nothing: true, status: :unauthorized
      end
  end

  # GET /questions
  # GET /questions.json
  def index
		if params[:test] == nil
		   @questions = Question.all 
	    else
	      @test_id   = params[:test]
        @test      = Test.find(@test_id)
	   		@questions = Question.where(test_id: params[:test])	    	
	   		@question  = Question.new 

     		if @questions[0]==nil
          @questions[0] = Question.create
	   			@questions[0].test_id = @test_id
	   		end

	   		@test_name = @questions[0].test.name
	   		@answer = Answer.new 
       end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  	respond_to do |format|
        format.html
        format.js {head :no_content }  
        format.json { render  'show' }
    end
  end

  # GET /questions/new
  def new
    @question = Question.create
    
    @question.test_id = params[:test_id]
    @question.save
    
    
    
    respond_to do |format|
    format.html { } # in the case of disabled JS support
    format.js
  end

  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

	def save_all
		params["questions"].each() do |(key,value)|
        	@question=Question.find(key)
        	if(@question!=nil)
	        	@question.update(value)
        	end	
		end
    	params["answers"].each do |(key,value)| 
	        @answer=Answer.find(key)
        	@answer.update(value)
    	end
   
	end

  	def delete_all
		@test_id = params["test_id"]
		Question.delete_all(:test_id => @test_id)
		Answer.delete_all(:test_id => @test_id)
 		respond_to do |format|
	        format.html { }
        	format.js { head :no_content }
    	end		

	end
    
   
  
  def formQuestions
    test= Test.find(params["test_id"])
    
    delete_all()
    if test.test_type==2 
       qtext2 = params["question_text2"].split("\n")
       i=0
    end   
	  params["question_names"].split("\n").each do |value|
         q = Question.new()
         q.text = value
         q.test_id = params["test_id"]
         if test.test_type==2 
            q.text2   = qtext2[i]
            i=i+1
         end   
         q.save
      end
  end  
  
  def form_answers
    
    Answer.delete_all(:test_id => params["test_id"])
     qs = Question.where(test_id: params["test_id"])
     qs_values = params["answer_values"].split("\n") 
     qs.each do |q|
      i=0
       params["answer_names"].split("\n") .each do |value|
         a = Answer.new()
         a.text          = value
         a.answer_value = qs_values[i]
         a.test_id 	     = params["test_id"]
         a.question_id   = q.id
         a.save	         
         i += 1
    end    
  end
  end  
  

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.js { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:text, :test_id)
    end
end
