Rails.application.routes.draw do
  resource :feedback, only: :create, controller: 'fdbq/feedback'
end
