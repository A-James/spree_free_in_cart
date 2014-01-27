spree_free_in_cart
====================

Default product Id's are

````ruby
Spree::AppConfiguration.class_eval do
  preference :main_item_sku, :string, default: "PROD-MAIN"
  preference :free_item_sku, :string, default: "PROD-FREE"
end
````

If you need custom ones copy `/app/models/spree/app_configuration_decorator.rb` into your spree project and edit the two variables with you primary and free product ID.