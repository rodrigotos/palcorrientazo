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

  private

  def establishment_params
    params.require(:establishment).permit(:name, :zone, :longitude, :latitude, :description, :price, :category)
  end

end
