require File.dirname(__FILE__) + '/../config'
require 'activeresource'

class Card < ActiveResource::Base
    self.site = $url
end
