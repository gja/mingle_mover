class CardColumn
    def initialize(name, header = nil, &action)
        @name = name
        @header = header
        @action = action

        @header = name if not @header
        @action = proc { |item| item.attributes[@name] } if not @action
    end

    def value(item)
        @action.call(item)
    end

    attr_reader :header, :name
end
