class EstablishmentsController < ApplicationController
  def new
      @establishment = Establishment.new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    @establishments = Establishment.all
  end

  def show
  end

  def search_by_name
    @establishments = []
    @establishments = Establishment.where("name LIKE ?", "%#{params[:establishment_name]}%" ) unless params[:establishment_name].blank?
    @establishment_name = params[:establishment_name]
  end

  def general_search
    @establishments = []
    @general_name = !params[:establishment_general_name].blank? ? params[:establishment_general_name] : ""
    @zone = !params[:establishment_zone].blank? ? params[:establishment_zone] : "norte"
    @likes = !params[:establishment_likes].blank? ? params[:establishment_likes].to_i : 0
    @establishments = Establishment.where(
    "name LIKE ?", "%#{@general_name}%"
    ).where(
      zone: @zone
    ).where(
      "like_count <= ? and like_count > 0", @likes.to_i
    )
  end

end
