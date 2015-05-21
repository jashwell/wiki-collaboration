class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create

    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was added."
    else
      flash[:error] = "Error creating Wiki."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
      redirect_to @wiki
    else
      flash[:error] = "Error saving topic."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "Wiki was deleted succcessfully."
      redirect_to action: "index"
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end

end
