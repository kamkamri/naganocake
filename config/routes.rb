Rails.application.routes.draw do

 # 顧客用デバイス
  # URL /customers/sign_in ...
  # devise_for :customers, skip: [:passwords, :registrations], controllers: {
    # registrations: "public/registrations", only:[:new, :create],
    # sessions: 'public/sessions'
  # }

  devise_for :customers, skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # devise_scope :customers do
  #   get 'customers/sign-up' => 'public/registrations#new', as: :new_customer_registration
  #   post 'customers' => 'public/registrations#create', as: :customer_registration

  # end



  # 管理者用デバイス
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }



# ◆顧客用　public
  # scopeを使って、アドレスには反映しないまとまりを作る
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :items, only:[:index, :show]

    resource :customers, only:[:show]
      get 'customers/information/edit' => 'customers#edit'
      patch 'customers/information' => 'customers#update'
      get 'customers/confirm' => 'customers#confirm'
      patch 'customers/withdrawal' => 'customers#withdrawal'

    resources :cart_items, only:[:index, :update, :destroy, :create]
    delete 'cart_items' => 'cart_items#destroy_all', as: 'destroy_all'

    resources :orders, only:[:new, :create, :index, :show]
    post 'orders/confirm'
    get 'orders/complete'

    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end


# ◆管理者用　admin
  namespace :admin do
    # get 'orders/show'
    root to: 'homes#top'
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_items, only:[:update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
