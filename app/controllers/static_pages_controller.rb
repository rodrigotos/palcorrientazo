class StaticPagesController < ApplicationController
  def welcome
    @establishments = Establishment.limit(5)
  end
end
