require 'activeresource'

class Transition < ActiveResource::Base
    self.site = $url
end
