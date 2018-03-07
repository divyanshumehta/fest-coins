class TranscationController < ApplicationController

  def transfer
    if params[:email].nil? || params[:email].blank?
      flash[:danger] = "No valid destination user"
      puts "ERR DEST USER1"
      redirect_to root_path
      return
    end
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
    if amount <= 0
      flash[:danger] = "Enter valid transfer amount"
      redirect_to root_path
      return
    end
    src = current_user
    if src == dest
      flash[:danger] = "Sorry can't transfer money to yourself"
      redirect_to root_path
      return
    end
    puts amount
    puts src
    puts dest
    t = Transcation.new
    t.user_id = src.id
    t.receiver = dest.email
    t.amount = amount
    src.coins -= amount
    src.save
    dest.coins += amount
    dest.save
    t.save
    flash[:notice] = amount.to_s + " Aavishkar Coins transfered to " + dest.name
    redirect_to root_path
  end
end
