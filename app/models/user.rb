class User < ApplicationRecord
  has_many :transcations
  before_create :initial_coins_promo_code

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.image = auth['info']['image'] || "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQm1ImiHojbK65t0NgsFVP9Mv0Mct895OefF06vvzM06GIx8u4SA"
      end
    end
  end

  def initial_coins_promo_code
    self.coins = 50
    t=Transcation.new
    t.receiver = self.email
    t.amount = 50
    t.user_id = User.first.id
    t.save
    self.promo_code = "AVSKR"
    self.name.split(" ").each do |word|
      self.promo_code += word[0].upcase
    end
    self.promo_code += (User.last.id+54).to_s
  end

end
