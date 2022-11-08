Rails.application.routes.draw do

  resources :leases, only: [:create, :destroy]
  resources :apartments
  resources :tenants
  
end
