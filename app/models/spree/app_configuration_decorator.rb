Spree::AppConfiguration.class_eval do
  preference :main_item_sku, :string, default: "ROR-00002"
  preference :free_item_sku, :string, default: "ROR-00002-free"
end
