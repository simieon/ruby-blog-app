class TodoController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index

    if params[:searchText].present?
      @todos = Todo.text_search(params[:searchText])
    elsif params[:show_up_date].present?
      date = Date.parse(params[:show_up_date])
      @todos = Todo.pagination_todo(date.present? ? date : Date.today)
    else
      Todo.uncompleted.update_all(deadline: Date.today)
      @todos = Todo.pagination_todo(Date.today + 7)
    end
  end

  def create
     if Todo.create(text: params[:text], deadline: params[:deadline])
       head :ok
     else
       head :not_found
     end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to '/'
  end

  def update
    @todo = Todo.find(params[:id])

    if @todo.update(:is_completed => params[:is_completed])
      head :ok
    else
      head :not_found
    end
  end

  private
  def todo_params
    params.require(:todo).permit(:text)
  end
end
