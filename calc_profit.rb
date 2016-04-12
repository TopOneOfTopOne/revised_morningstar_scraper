
class Stock
  attr_accessor :sym , :p_cum , :cps, :amount_spent, :p_ex, :profit , :dividends, :amount_of_shares , :profit , :profit_with_franking , :time, :franking, :yield, :hypo_price
  def initialize(p_cum,cps,amount_spent,franking)
    @cps                     = cps.to_f
    @p_cum                   = p_cum.to_f
    @amount_spent            = amount_spent
    @amount_of_shares        = @amount_spent/@p_cum
    @franking                = franking.to_f/100
    @dividends               = @amount_of_shares * (@cps/100.0)
    @franking_credits        = ((@dividends/0.7) - @dividends) * @franking
    @yield                   = (cps/p_cum)
    @hypo_price              = (p_cum - (((@cps/100.0)/( 1 - ( (@franking)*0.3 ) )) * (1-0.45))).round(4)
    @profit_hypo_price       = -@amount_spent + (@hypo_price * @amount_of_shares) + @dividends
  end

  def details
    "Amount spent: #{@amount_spent}
     Num of shares: #{@amount_of_shares}
     Hypothesis price: #{@hypo_price}
     profit_hypo_price: #{@profit_hypo_price}
     franking_credits: #{@franking_credits}"
  end
end
