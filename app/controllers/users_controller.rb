class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, :except => [:index, :search]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    response = {}
    array = []
    puts params[:name]
    users = User.where("lower(name) like ?","%#{params[:name].downcase}%")
    if users.count > 0 and users.count <= 7
      users.each do |user|
        array << {name:user.name, image:user.image, email:user.email}
      end
      response = {data: array, status: "OK"}
    elsif users.count > 7
      response = {status: "limit"}
    else
      response = {status: "none"}
    end
    respond_to do |format|
      format.json { render json: response }
    end
  end

end
