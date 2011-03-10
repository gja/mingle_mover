require 'sinatra'
require 'haml'

require 'config'
require 'mingle_mover'

$:.unshift File.dirname(__FILE__) + "/lib/"

class Card
  include CardWeb
end

set :haml, :format => :html5
set :show_exceptions => false

get "/" do
  haml :home, :layout => false, :locals => {:branches => ["master", "workflow"]}
end

get "/branch/:branch" do |branch|
  haml :branch, :layout => false, :locals => {:cards => get_cards(branch)}
end
