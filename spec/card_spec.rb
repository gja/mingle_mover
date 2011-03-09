require 'config'

describe Card do
    before do
        card42 = Card.new(:number => 42, :id =>2342323, :name => "Something Cool")
        card42.properties = [{:name => "foo", :value => "bar"}, {:name => "Status", :value => "New"}]

        bug43 = Card.new(:number => 43, :id =>2342323, :name => "Something Buggy")
        bug43.properties = [{:name => "foo", :value => "bar"}, {:name => "Defect Status", :value => "Ugly"} ]

        unknown44 = Card.new(:number => 44, :id =>2342323, :name => "Something Weird")
        unknown44.properties = [{:name => "foo", :value => "bar"}]
        
        ActiveResource::HttpMock.respond_to do |mock| 
            mock.get "/cards/42.xml", {}, card42.to_xml
            mock.get "/cards/43.xml", {}, bug43.to_xml
            mock.get "/cards/44.xml", {}, unknown44.to_xml
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
        Card.find(42).status.should == "New"
        Card.find(43).status.should == "Ugly"
        Card.find(44).status.should == "none"
    end

    it "Should Have Committer set when passed properties" do
        card = Card.find_with_properties({:number => 42, :committer => "Tejas Dinkar" })
        card.name.should == "Something Cool"
        card.committer.should == "Tejas Dinkar"
    end

    it "Should be able to get the url to view the card" do
        $safe_mingle_instance = "http://mingle.com"
        $project_name = "foo"
        card = Card.find 42

        card.url.should == "http://mingle.com/projects/foo/cards/42"
    end
end
