Spree::BaseController.class_eval do

  before_filter :load_header_product

  private

  def load_header_product
    @variant = Spree::Variant.find_by_sku(Spree::Config[:main_item_sku])
    if @variant
      @featured_product = @variant.product
    end
  end

end
