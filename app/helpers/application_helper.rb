module ApplicationHelper

  # Two functions that help extract the current line item for the main product
  # and a secondary method for getting the free count. We need to make sure that
  # the offset is always equal if we're asking for values so things are kept inline

  def cart_primary_item_count(starter = 1, offset=0)
    current_order.present? && current_order.line_items.count > 0 ? current_order.line_item_count(offset) : starter
  end

  def cart_free_item_count(starter = 1, offset=0)
    current_order.present? && current_order.line_items.count > 0 ? current_order.line_item_count(offset).number_free : starter.number_free
  end

end
