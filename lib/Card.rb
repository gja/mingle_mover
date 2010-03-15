class Card < ActiveResource::Base
    self.site = $url

    def id
        number
    end

    def transitions
        get(:transitions).map {|props| Transition.new props }
    end
end
