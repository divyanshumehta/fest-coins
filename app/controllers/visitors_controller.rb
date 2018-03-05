class VisitorsController < ApplicationController

  def index
    if user_signed_in?
      out_transcations = current_user.transcations
      in_transcations = Transcation.where(receiver:current_user.email)
      @transcations = []
      out_transcations.each do |out|
        @transcations<<{beneficiary:out.receiver, amount:out.amount, in_out:"out", time_stamp:out.created_at}
      end
      in_transcations.each do |income|
        src = income.user.email
        @transcations<<{beneficiary: src, amount:income.amount, in_out:"in", time_stamp:income.created_at}
      end
      @transcations.sort_by { |hsh| hsh[:time_stamp] }
    end
  end

end
