require 'activeresource'

class Card < ActiveResource::Base
    self.site = $url

    def transitions
        get(:transitions).map {|props| Transition.new props }
    end
end
