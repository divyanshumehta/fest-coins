class UsersController < ApplicationController
  before_action :authenticate_user!

  def refferal
    reffered_user = User.where(promo_code: params[:refferal_code]).first
    if reffered_user == current_user
      flash[:danger] = "Sorry :( You cannot use our own promo code"
      redirect_to root_path
      return
    end
    if reffered_user
      reffered_user.coins +=25
      current_user.coins +=25
      reffered_user.save
      current_user.reffered_promo_code = reffered_user.promo_code
      current_user.save
      t=Transcation.create(amount:25, user_id:User.first.id, receiver:current_user.email)
      t=Transcation.create(amount:25, user_id:User.first.id, receiver:reffered_user.email)
      flash[:notice] = "Sucessfully used refferal code"
      redirect_to root_path
    else
      flash[:danger] = "Oops that was not a valid refferal code"
      redirect_to root_path
    end
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
