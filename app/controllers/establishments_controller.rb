class EstablishmentsController < ApplicationController

  before_action :authenticate_user!,  :except => [:general_search, :search_by_name]

  def new
      @establishment = Establishment.new
  end

  def create
    @establishment = Establishment.new(establishment_params)
    @establishment.user = current_user
    @establishment.state = true
    @establishment.avg_qualification = 0
    @establishment.like_count = 0
    if @establishment.save
        flash[:success] = "Establishment created. Ok"
        redirect_to establishments_path
    else
      render 'new'
    end
  end

  def update
    @establishment = Establishment.find_by(id: params[:id])
    @establishment.user = current_user
    @establishment.state = true
    if @establishment.update(establishment_params)
      flash[:success] = "Establishment updated. Ok"
      redirect_to establishments_path
    else
      flash[:error] = "Houston we are in troubles, try it again."
      render 'edit'
    end
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
    @establishments = current_user.establishments
  end

  def show
    @establishment = Establishment.find_by(id: params[:id])
    @qualifications = Qualification.includes(:user).where(establishment_id: params[:id]).all
    @qualification = Qualification.new
    if @establishment.nil?
    flash[:error] = "Houston we are in troubles, please dont hack us."
    redirect_to root_path
  end
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
      "like_count <= ? and like_count >= 0", @likes.to_i
    )
  end

  def create_qualification
    @establishment = Establishment.find(params[:id])
    @qualification = Qualification.new(qualifitacion_params)
    @qualification.user_id = current_user.id
    @qualification.establishment_id = @establishment.id
    if @qualification.save
        #Consultar todas las calificaciones de ese y sacar el promedio para actualizarlo
        @count_qualifications = Qualification.where(establishment_id: @establishment.id).all.count
        @qualifitacion_avg = ((@establishment.avg_qualification * (@count_qualifications - 1)) + @qualification.qualification) / @count_qualifications
        @establishment.avg_qualification = @qualifitacion_avg
        if @establishment.save
          flash[:success] = "Have you rated the establishment"
        else
          flash[:error] = "Houston we are in troubles, try it again."
        end
    end
    redirect_to establishment_path(@establishment)
  end

  def create_like
    @establishment = Establishment.find(params[:id])
    @like = Like.new
    @like.user_id = current_user.id
    @like.establishment_id = @establishment.id
    if @like.save
        @like_count = @establishment.like_count + 1
        @establishment.like_count = @like_count
        if @establishment.save
          flash[:success] = "Saved"
        else
          flash[:error] = "Houston we are in troubles, try it again."
        end
    end
    redirect_to root_path
  end

  private

  def establishment_params
      params.require(:establishment).permit(:name, :zone, :longitude, :latitude, :description, :price, :category)
  end

  def qualifitacion_params
    params.require(:qualification).permit(:qualification, :comment)
  end

end
