activate :directory_indexes
activate :automatic_image_sizes

set :css_dir,     'stylesheets'
set :js_dir,      'javascripts'
set :images_dir,  'images'

configure :build do
  set :http_prefix, '/equation-sheet' # this is because I deploy to http://nserror.me/equation-sheet/
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
end
