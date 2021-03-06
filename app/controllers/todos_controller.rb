class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:show, :edit, :update, :destroy]


  # GET /todos
  # GET /todos.json
  def index
    @todos = current_user.todos.where(completed: false)
    @completes = current_user.todos.where(completed: true)
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = current_user.todos.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = current_user.todos.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_url }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    @todo = current_user.todos.find(params[:id])
    if @todo.update_attribute(:completed, true)
      redirect_to todos_url
    else
      render "edit"
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    # complete
      respond_to do |format|
        if @todo.update(todo_params)
          format.html { redirect_to todos_url, notice: 'Todo was successfully updated.' }
          format.json { render :show, status: :ok, location: @todo }
        else
          format.html { render :edit }
          format.json { render json: @todos.errors, status: :unprocessable_entity }
        end
    end
  end


  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = current_user.todos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:name, :completed, :user_id)
    end

end
