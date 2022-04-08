Rails.application.routes.draw do
  get '/products' => "products#index"
  
  get 'carts/:id' => "carts#show", as: "cart"
  post 'carts/:id' => "carts#clear_cart", as: "clear_cart"
  delete 'carts/:id' => "carts#destroy"

  post 'line_items/:id' => "line_items#create", as: "line_items_create"
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"

  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  
  post 'carts/:id/orders' => "orders#create", as: "orders"
  
  root to: "products#index"
end
