spree_free_in_cart
====================

Installation
------------

Add spree_free_in_cart to your `Gemfile`:

```ruby
gem 'spree_free_in_cart', git: 'https://github.com/200Creative/spree_free_in_cart', branch: '2-1-stable'
```
And run

```bash
bundle install
```

Then in your `/app/views/spree/orders/edit.html.erb` file in your main project, remove the cart part of the template and replace it with:

````html
    <!-- Includes cart partial from either spree_free_in_cart or spree_multibuy_cart gem  -->
    <%= render :partial => 'spree/orders/promotional_cart' %>
````

Done.

Useage
------------

Default product Id's are

````ruby
Spree::AppConfiguration.class_eval do
  preference :main_item_sku, :string, default: "PROD-MAIN"
  preference :free_item_sku, :string, default: "PROD-FREE"
end
````

If you need custom ones copy `/app/models/spree/app_configuration_decorator.rb` into your spree project and edit the two variables with you primary and free product ID.