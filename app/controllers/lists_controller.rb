class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update]

  def index
    @lists = List.order(created_at: :desc)
  end

  def new
    @list = List.new
  end

  def show
    @bookmark = @list.bookmarks.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: "Lista creada exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: "Lista actualizada correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
