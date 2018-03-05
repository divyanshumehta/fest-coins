class TranscationController < ApplicationController

  def transfer
    dest = User.where(email:params[:email]).first
    if dest.nil?
      flash[:danger] = "No valid destination user"
      puts "ERR DEST USER"
      redirect_to root_path
      return
    end
    amount = params[:amount].to_i
    if amount > current_user.coins
      flash[:danger] = "You do not have sufficent coins"
      redirect_to root_path
      return
    end
    src = current_user
    puts amount
    puts src
    puts dest
    t = Transcation.new
    t.user_id = src.id
    t.receiver = dest.email
    t.amount = amount
    src.coins -= amount
    dest.coins += amount
    t.save
    src.save
    dest.save
    flash[:success] = amount.to_s + " Aavishkar Coins transfered to " + dest.name
    redirect_to root_path
  end
end
