class EstablishmentsController < ApplicationController

  before_action :authenticate_user!

  def new
      @establishment = Establishment.new
  end

  def create
    @establishment = Establishment.new(establishment_params)
    @establishment.user = current_user
    @establishment.state = true
    if @establishment.save
        flash[:success] = "Establishment created. Ok"
        redirect_to establishments_path
    else
      render 'new'
    end
  end

  def update
  end

  def edit
      @establishment = Establishment.find_by(id: params[:id])
    if @establishment.nil?
      flash[:error] = "Houston we are in troubles, please dont hack us."
      redirect_to establishments_path
    end
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

  private

    def establishment_params
      params.require(:establishment).permit(:name, :zone, :longitude, :latitude, :description, :price, :category)

end
