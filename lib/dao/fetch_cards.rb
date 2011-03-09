class FetchCards
    def fetch(properties)
        threads = properties.map do |prop|
          Thread.new(prop) do |p| 
            begin
              Card.find_with_properties p
            rescue
              nil
            end
          end
        end

        threads.map! { |thread| thread.value }
    end
end
