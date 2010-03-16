class FetchCards
    def fetch(properties)
        threads = properties.map do |prop|
            Thread.new(prop) { |p| Card.find_with_properties p }
        end

        threads.map! { |thread| thread.value }
    end
end
