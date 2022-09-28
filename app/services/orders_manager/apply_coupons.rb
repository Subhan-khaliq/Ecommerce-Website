# frozen_string_literal: true

module OrdersManager
  class ApplyCoupons
    def initialize(promo_code:, order:)
      @code = promo_code
      @order   = order
    end

    def call
      result = apply_coupons
    rescue apply_coupons::Error => e
      OpenStruct.new({ success?: false, error: e })
    else
      OpenStruct.new({ success?: true, payload: result })
    end

    private

    def apply_coupons
      @coupon = Coupon.find_by(code: @code)
      after_discount = @order.sub_total - @order.percent_of(@coupon.discount, @order.sub_total)
      @order.update(sub_total: after_discount)
    end
  end
end
