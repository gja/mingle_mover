class CardColumn
    def initialize(name, header = nil, &action)
        @name = name
        @header = header
        @action = action

        @header = name if @header == nil
        @action = proc { |item| item.attributes[@name] } if @action == nil
    end

    def value(item)
        @action.call(item)
    end

    attr_reader :header, :name
end
