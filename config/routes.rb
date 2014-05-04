Stats::Application.routes.draw do
  root 'pages#index'

  get 'top_urls' => 'pages#top_urls'
  get 'top_referrers' => 'pages#top_referrers'

end
