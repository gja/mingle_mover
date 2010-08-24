$url = "http://localhost"

require File.dirname(__FILE__) + '/../mingle_mover'

require 'active_resource/http_mock'
require 'mocha'
require 'ruby_signal_spy'

def create_app
  puts "Creating Qt Application\n"
  Qt::Application.new(ARGV)
end

Spec::Runner.configure do |config|
    config.mock_with :mocha
end

@app = @app || create_app
