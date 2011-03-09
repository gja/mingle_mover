require 'ostruct'

class FetchCards
    def fetch(properties)
        threads = properties.map do |prop|
          Thread.new(prop) do |p| 
            begin
              Card.find_with_properties p
            rescue
              OpenStruct.new(:number => p[:number], :url => $safe_mingle_instance, :committer => p[:committer], :name => "Unable to load card", :status => "Unknown")
            end
          end
        end

        threads.map! { |thread| thread.value }
    end
end
