require 'config'

class Card
  include CardWeb
end

describe Card do
    before do
        card42 = Card.new(:number => 42, :id =>2342323, :name => "Something Cool")
        card42.properties = [{:name => "foo", :value => "bar"}, {:name => "Status", :value => "Good"}]

        bug43 = Card.new(:number => 43, :id =>2342323, :name => "Something Buggy")
        bug43.properties = [{:name => "foo", :value => "bar"}, {:name => "Defect Status", :value => "Ugly"} ]

        unknown44 = Card.new(:number => 44, :id =>2342323, :name => "Something Weird")
        unknown44.properties = [{:name => "foo", :value => "bar"}]

        $good_status = ["Good"]
        $ugly_status = ["Ugly"]
        
        ActiveResource::HttpMock.respond_to do |mock| 
            mock.get "/cards/42.xml", {}, card42.to_xml
            mock.get "/cards/43.xml", {}, bug43.to_xml
            mock.get "/cards/44.xml", {}, unknown44.to_xml
        end
    end

    it "Should Get The Status" do
        Card.find(42).style.should == "color: green"
        Card.find(43).style.should == "color: red"
        Card.find(44).style.should == "color: black"
    end
end
