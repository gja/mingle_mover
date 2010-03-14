require 'config'

describe Card do
    before do
        ActiveResource::HttpMock.respond_to do |mock|            
            mock.get "/cards/42.xml", {}, Card.new(:id => 42, :name => "Something Cool").to_xml
            mock.get "/cards/42/transitions.xml", {}, [Transition.new(:id => 10, :name => "Descoped")].to_xml
        end
    end

    it "Should Get A Card From Mingle" do
        card = Card.find(42)
        card.name.should == "Something Cool"
    end

    it "Should Get The Transitions From Mingle" do
        card = Card.find(42)
        transitions = card.transitions
        transitions.length.should == 1
        transitions[0].name.should == "Descoped"
    end
end
