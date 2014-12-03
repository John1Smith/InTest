InTest::Application.routes.draw do


  

  

 

  resources :tests

  resources :main

  get "welcome/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  #get 'questions/save_all', to: 'questions#show'
 
  get 'results/all_results' => 'results#all_results' 

  post 'questions/save_all' => 'questions#save_all' 
  get 'questions/delete_all' => 'questions#delete_all'   

  post 'questions/formQuestions' => 'questions#formQuestions' 
  post 'questions/form_answers' => 'questions#form_answers' 

  post 'results/save_all' => 'results#save_all' 
  get 'users/show_result' => 'users#show_result' 
  

  post 'scales/save_all' => 'scales#save_all' 
  get  'scales/delete_all' => 'scales#delete_all'   
 
  post 'interpretations/save_all_inters' => 'interpretations#save_all_inters' 
  get  'interpretations/delete_all_inters' => 'interpretations#delete_all_inters'    
 
 resources :results

  resources :questions

  resources :users

  resources :answers   

  resources :interpretations

  resources :scale_results

  resources :scales  
         
  #
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

