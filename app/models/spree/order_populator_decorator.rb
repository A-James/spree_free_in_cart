Spree::OrderPopulator.class_eval do

  private

  def attempt_cart_add(variant_id, quantity)
    quantity = quantity.to_i
    # 2,147,483,647 is crazy.
    # See issue #2695.
    if quantity > 2_147_483_647
      errors.add(:base, Spree.t(:please_enter_reasonable_quantity, :scope => :order_populator))
      return false
    end

    variant = Spree::Variant.find(variant_id)
    if quantity > 0
      line_item = @order.contents.add(variant, quantity, currency)
      unless line_item.valid?
        errors.add(:base, line_item.errors.messages.values.join(" "))
        return false
      end
    end

    ################################################################################
    # CUSTOM
    # Unforunately we need to override the entire
    # method to add the section below.
    # Remove any items that a user might hit the back button on and try to add more
    ################################################################################

    @order.line_items.each { |l| l.quantity = 0  if l.variant.sku == Spree::Config[:free_item_sku]}
    @order.save!
    
    @order.add_free_item(currency)

  end
end
