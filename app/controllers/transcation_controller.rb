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

  def coupon
    coupon_code = params[:coupon_code]
    if coupon_code.nil? || coupon_code.blank?
      flash[:danger] = "Blank coupon code"
      redirect_to root_path
      return
    end
    coupon = Coupon.where(code: coupon_code).first
    if coupon.nil?
      flash[:danger] = "Invalid Coupon code"
      redirect_to root_path
      return
    end
    puts coupon
    if coupon.active==false
      flash[:danger] = "Opps soory :( Coupon code expired"
      redirect_to root_path
      return
    end
    if current_user.coupons_used.include? coupon_code
      flash[:danger] = "Soory :( but you alreay used this code"
      redirect_to root_path
      return
    end
    current_user.coins += coupon.amount
    current_user.coupons_used.append(coupon_code)
    t=Transcation.new
    t.receiver = current_user.email
    t.amount = coupon.amount
    t.user_id = User.first.id
    t.save
    current_user.save
    flash[:notice] = "Yeah!! you earned "+coupon.amount.to_s+" Eurekoins via "+coupon_code
    redirect_to root_path
  end

end
