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
end