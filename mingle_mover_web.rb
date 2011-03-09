require 'sinatra'
require 'haml'

require 'config'
require 'mingle_mover'

$:.unshift File.dirname(__FILE__) + "/lib/"

set :haml, :format => :html5
set :show_exceptions => false

get "/" do
  haml :home, :layout => false, :locals => {:cards => get_cards}
end
