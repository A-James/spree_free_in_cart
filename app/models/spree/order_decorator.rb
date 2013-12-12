Spree::Order.class_eval do

  def line_item_count(offset=0)
    items_count = 0 
    line_items.each { |l| items_count = l.quantity if l.variant.sku == Spree::Config[:main_item_sku]}
    items_count += offset
    return items_count
  end
  
  def add_free_item(current_currency)
    # By now the item has been added so we can apply our math logic for the
    # free amounts.
    free_variant = Spree::Variant.find_by_sku(Spree::Config[:free_item_sku])

    line_items_count = 0 

    line_items.each { |l| line_items_count = l.quantity  if l.variant.sku == Spree::Config[:main_item_sku]}

    if line_items_count.number_free > 0
      # We use the "number_free" function from the rounding initializer on 
      # the line_items_count of the overall line items which are one particular product.
      self.contents.add(free_variant, line_items_count.number_free, current_currency)
    else
      line_items.each do |item|
        if item.variant.sku != Spree::Config[:main_item_sku]
          item.destroy
        end
      end
    end
  end  
end