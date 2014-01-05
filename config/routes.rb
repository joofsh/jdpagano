# Dynamically build regex including a zero-width negative lookahead for each subdomain we use
SUBDOMAINS = %w(tech travel) # array of all subdomains used
subdomain_str = '|^(?!'
SUBDOMAINS.each { |s| subdomain_str << "#{s}|" }
subdomain_str = subdomain_str[0..-2]
subdomain_str << ").*"

BLANK_STRING_PATTERN = "^$"            # matches blank subdomain
SUBDOMAIN_PATTERN = Regexp.new(BLANK_STRING_PATTERN + subdomain_str)


Jdpagano::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Removes the www. from the beginning of the request URL,
  # but maintains the rest of the subdomain if one exists
  constraints subdomain: /^www/ do
    get '(*any)' => redirect { |p, request| request.url.sub('www.','') }
  end


  # Checks for a blank or non-Blog subdomain
  # If there is no subdomain or an invalid one, we redirect to the tech blog
  constraints subdomain: SUBDOMAIN_PATTERN do |p, req|
    get '(*any)' => redirect(subdomain: 'tech', path: '/%{any}/'), any: /.*/
  end

  root 'main#index'

  get 'login' => 'sessions#new', as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'
  resources :sessions
  resources :articles, except: [:show]
  get 'articles/:slug' => 'articles#show'


  get '*path', to: 'main#missing'
end
