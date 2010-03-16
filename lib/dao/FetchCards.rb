class FetchCards
    def fetch(properties)
        return fetch_without_thread(properties) if RUBY_PLATFORM == "i386-mswin32"
        return fetch_with_thread(properties)
    end

    def fetch_with_thread(properties)
        threads = properties.map do |prop|
            Thread.new(prop) { |p| Card.find_with_properties p }
        end

        threads.map! { |thread| thread.value }
    end

    def fetch_without_thread(properties)
        properties.map do |prop|
            Card.find_with_properties prop
        end
    end
end
