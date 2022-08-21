Rails.application.routes.draw do

  # ◆ルーティングのポイント
  # 1 resourceか、resourceで、基本書く
  # 2 自分で記述するものは、collection doか、member do で、resourceにくっつけて書く
  # 3 やむなく、自分で記述する場合は、同じコントローラーを使用するresourseより、前に書く

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

    #◆次回は、collection doで、書く方がいい
    # resource :customers, only:[:show] do
    #   collection do
    #     get 'information/edit', action: 'edit'    #’’クォーテーションで囲む場合、:で記述する場合、どっちでもOK
    #     patch :information, action: :update
    #     get 'confirm'
    #     patch 'withdrawal'
    #   end
    # end

    resources :cart_items, only:[:index, :update, :destroy, :create]
    delete 'cart_items' => 'cart_items#destroy_all', as: 'destroy_all_cart'

    resources :orders, only:[:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end


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
