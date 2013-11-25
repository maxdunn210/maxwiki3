Maxwiki3::Application.routes.draw do
  match 'maxwiki_gmap/show/:action/:id' => 'maxwiki_gmap#show#index'
  match 'rss_with_headlines' => 'wiki#rss_with_headlines'
  match 'rss_with_content' => 'wiki#rss_with_content'
  match '_edit/:link' => 'wiki#edit'
  match '_editt/:link' => 'wiki#edit', :editor => 'textile'
  match '_editw/:link' => 'wiki#edit', :editor => 'wysiwyg'

  root :to => "wiki#show", :link => 'homepage', :via => :get
  match 'index.htm' => 'wiki#show', :link => 'homepage'
  match ':link' => 'wiki#show'
  match '_action/wiki/:action/:link' => 'wiki#index'
  match '_action/wiki/show/:link' => 'wiki#show'
  match '_action/:controller(/:action(/:id(.:format)))'
end
