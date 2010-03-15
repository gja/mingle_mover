require 'config'

describe Card do
    before do
        card42 = Card.new(:number => 42, :id =>2342323, :name => "Something Cool")
        card42.properties = [{:name => "foo", :value => "bar"}, {:name => "Status", :value => "New"}]
        
        ActiveResource::HttpMock.respond_to do |mock| 
            mock.get "/cards/42.xml", {}, card42.to_xml
            mock.get "/cards/42/transitions.xml", {}, [Transition.new(:id => 10, :name => "Descoped")].to_xml
        end
    end

    it "Should Get A Card From Mingle" do
        card = Card.find(42)
        card.name.should == "Something Cool"
    end

    it "Should Override the Id with the Card number" do
        card = Card.find(42)
        card.id.should == 42
    end

    it "Should Get The Transitions From Mingle" do
        card = Card.find(42)
        transitions = card.transitions
        transitions.length.should == 1
        transitions[0].name.should == "Descoped"
    end

    it "Should Get The Status" do
        card = Card.find(42)
        card.status.should == "New"
    end
end
