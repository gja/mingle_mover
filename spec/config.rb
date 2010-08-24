$url = "http://localhost"

require File.dirname(__FILE__) + '/../mingle_mover'

require 'active_resource/http_mock'
require 'mocha'

def create_app
  puts "Creating Qt Application\n"
  Qt::Application.new(ARGV)
end

@app = @app || create_app
