class EstablishmentsController < ApplicationController
  def new
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
  end

  def search_by_zona
  end 

end
