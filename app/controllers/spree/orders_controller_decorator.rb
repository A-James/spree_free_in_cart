Spree::OrdersController.class_eval do

  def update
    @order = current_order
    unless @order
      flash[:error] = Spree.t(:order_not_found)
      redirect_to root_path and return
    end

    if @order.update_attributes(order_params)
      @order.line_items = @order.line_items.select {|li| li.quantity > 0 }

      ################################################################################
      # Custom
      ################################################################################

      # Reset the free items each time the order is updated
      @order.line_items.each { |l| l.quantity = 0  if l.variant.sku == Spree::Config[:free_item_sku]}
      # And save so we don't encounter a frozen hash error.
      @order.save!

      # Add the free item after the order is saved.
      # We need to pass the currency too
      @order.add_free_item(current_currency)

      ################################################################################
      # END CUSTOM
      ################################################################################

      @order.ensure_updated_shipments
      return if after_update_attributes

      fire_event('spree.order.contents_changed')

      respond_with(@order) do |format|
        format.html do
          if params.has_key?(:checkout)
            @order.next if @order.cart?
            redirect_to checkout_state_path(@order.checkout_steps.first)
          else
            redirect_to cart_path
          end
        end
      end
    else
      respond_with(@order)
    end
  end
end
