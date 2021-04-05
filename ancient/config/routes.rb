Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
  #登录
	post "login" => "session#login"
  #登出
  post "logout" => "session#logout"
  #验证码校验
  post "step_captcha" => "session#step_captcha"
  #通用方法
  #文件展示
  get "show_file/:fpath" => "common#show_file"
  #上传文件
  post "upload_file" => "common#upload_file"
  
  resources :logs, only: [] do 
    collection do 
      post :error
    end
  end
  
  resources :users do 
    collection do 
      post :info
    end
    member do 
      post :setUserInfo
    end
  end

  resources :roles do 
    member do 
      get :permissions
    end 

    resources :role_permissions do 
      collection do 
        post :set
        post :setAction
      end
    end
  end
  resources :permissions do 
    resources :actions do 
      collection do 
        get :initActions
      end
    end
  end

  resources :menus, only: [] do 
    collection do 
      post :access_list
    end
  end
	
end
