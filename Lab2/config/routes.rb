Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :producto do
      collection do
        get :productos_con_categorias2
      end
    end
    resources :categorias
    post '/movimiento_inventario/:producto_id', to: 'movimiento_inventario#create'
    get '/movimiento_inventario/:id', to: 'movimiento_inventario#show'
    get '/movimientos_inventario/:id', to: 'movimiento_inventario#index'
    resources :movimiento_inventario, only: [:index, :show, :create, :update, :destroy], param: :id
  end
end
