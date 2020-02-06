Fdbq::Rails::Engine.routes.draw do
  resource :feedback, only: :create, controller: 'feedback'
end 
