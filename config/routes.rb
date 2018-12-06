Crystal::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :teachers, controllers:{registrations: "teachers/registrations"}
  ActiveAdmin.routes(self)

  resources :teachers, :only=>[]  do 
    get :basicInfor, :on => :collection
    get :editInfor, :on => :collection
    get :editinfo_experience, :on => :collection
    get :editinfo_plan, :on => :collection
    get :editinfo_study, :on => :collection
    get :editinfo_basic, :on => :collection
    post :updateInfor, :on => :collection
    get :paper, :on => :collection
    post :upload, :on => :collection
    get :order_all, :on => :collection
    get :order_unpay, :on => :collection
    get :order_reserving, :on => :collection
    get :order_transfer, :on => :collection
    get :messages, :on => :collection
    get :msg, :on => :collection
    get :detail,:on => :collection
    get :gallery,:on=>:collection
    get :show_menu,:on=>:collection
    get :sign_today,:on=>:collection
  end

  devise_for :parents, controllers: { registrations: "parents/registrations", sessions: "parents/sessions" }
  ActiveAdmin.routes(self)

  devise_scope :parent do
    get '/parent_validate', to: 'parents/sessions#parent_validate'
  end

  resources :parents, :only => [] do 
    get :activity, :on => :collection
    get :profile, :on => :collection
    get :modify_info, :on => :collection
    put :modify_info_changed, :on => :collection
    get :modify_password, :on => :collection
    put :modify_password_changed, :on => :collection
    get :order_all, :on => :collection
    get :order_unpay, :on => :collection
    get :order_reserving, :on => :collection
    get :order_refund, :on => :collection
    get :messages, :on => :collection
    get :msg, :on => :collection
    get :show_menu,:on=>:collection
  end

  resources :courses do
    get :select_second, :on=>:collection
    get :select_third, :on=>:collection
  end

  resources :addresses
  
  resources :comments, :only => [:index, :new, :create]
  
  resources :orders, :only => [:new, :create] do
    get :parent, :on => :collection
    get :teacher, :on => :collection
    get :parent_pay, :on => :collection
    get :teacher_pay, :on => :collection
  end

  resources :trades, :only => [:show] do
    post :alipay_notify, :on => :collection
  end

  resources :messages, :only => [:show]

  resources :notices, :only => [:index, :show] do
    get :list, :on=>:collection
    get :download, :on => :collection
  end

  resources :information, :only=>[:index, :show, :new, :create] do
    get :download, :on => :collection
  end

  resources :institutions, :only=>[:index]

  match '/activities/bonus' => 'activities#bonus'
  match '/activities/beauty' => 'activities#beauty'
  match '/activities/beauty2' => 'activities#beauty2'
  #post '/activities/vote_create2' => 'activities#vote_create2'
  #post '/activities/vote_code_validate' => 'activities#vote_code_validate'

  match '/filters/index' => 'filters#index'
  match '/filters/search' => 'filters#search'
  match '/subject/:number' => 'filters#subject'
  match '/filters/select/:school/:grade/:course/:sex/:period/:time',:controller => 'filters',:action => 'select'
  match '/login' => 'home#login'
  match '/sign_up' => 'home#sign_up'
  match '/flow' => 'home#flow'
  match '/tflow' => 'home#tflow'

  root :to => 'home#index'
end
