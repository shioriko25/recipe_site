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

devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
end



  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    get 'customers/unsubscribe'
    patch 'customers/withdrawal'
    resources :tags do
    get 'recipes', to: 'recipes#search'
   end
   get 'finder' => "recipes#finder"
   get 'rank' => "recipes#rank"
    resources :recipes, only: [:index, :new, :show, :edit, :create, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy] #URLに/:idを含めない形にしています
    end
    resources :customers, only: [:show, :edit, :update] do
      resources :comments, only: [:index]
      resources :favorites, only: [:index]
    end
  end


  namespace :admin do
    get 'homes/top'
    resources :customers, only: [:index, :show, :edit, :update]
    #resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :comments, only: [:index, :show, :destroy]
  end

end
