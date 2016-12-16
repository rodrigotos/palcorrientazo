class StaticPagesController < ApplicationController
  def welcome
    @establishments = Establishment.all
  end
end
