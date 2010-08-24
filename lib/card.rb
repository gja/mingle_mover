class Card < ActiveResource::Base
    self.site = $url

    def id
        number
    end

    def transitions
        get(:transitions).map {|props| Transition.new props }
    end

    def status
        property = get_property "Status"
        property = get_property "Defect Status" if not property

        return "none" if not property
        return property.value
    end

    def self.find_with_properties(properties)
        card = Card.find(properties[:number])
        card.committer = properties[:committer]
        return card
    end

    private
    def get_property(name)
        properties.detect { |p| p.name == name }
    end
end
