require 'config'
require 'activeresource'

class Card < ActiveResource::Base
    self.site = $url
end

card = Card.find(42)

print card.name
