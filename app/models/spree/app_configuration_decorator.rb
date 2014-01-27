Spree::AppConfiguration.class_eval do
  preference :main_item_sku, :string, default: "PROD-MAIN"
  preference :free_item_sku, :string, default: "PROD-FREE"
end
