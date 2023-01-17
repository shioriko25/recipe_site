Rails.application.routes.draw do

  root to: "public/homes#top"

   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 会員用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}



  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    get 'customers/unsubscribe'
    patch 'customers/withdrawal'
    resources :tags do
    get 'recipes', to: 'recipes#search'
   end
   get 'finder' => "recipes#finder"
    resources :recipes, only: [:index, :new, :show, :edit, :create, :update, :destroy] do
    resources :comments, only: [:index, :create, :destroy]
    resources :favorites, only: [:index] 
    resource :favorites, only: [:create, :destroy] #URLに/:idを含めない形にしています
    end
    resources :customers, only: [:show, :edit, :update]
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
  end


  namespace :admin do
    get 'homes/top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :comments, only: [:index, :show, :destroy]
    resources :sessions, only: [:new, :create, :destroy]
  end

end
