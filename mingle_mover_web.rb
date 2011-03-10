require 'sinatra'
require 'haml'

require 'config'
require 'mingle_mover'

$:.unshift File.dirname(__FILE__) + "/lib/"

class Card
  def style
        return 'color: red' if $ugly_status.include? status
        return 'color: green' if $good_status.include? status
        'color: black'
  end
end

set :haml, :format => :html5
set :show_exceptions => false

get "/" do
  haml :home, :layout => false, :locals => {:branches => ["master", "workflow"]}
end

get "/branch/:branch" do |branch|
  haml :branch, :layout => false, :locals => {:cards => get_cards(branch)}
end
