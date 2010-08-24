require 'config'

describe CardColumn do
    it "Should set the Header if it is not passed" do
        column = CardColumn.new "Name"
        column.header.should == "Name"
    end

    it "Should have header and name set" do
        column = CardColumn.new "Name", "Header"
        column.name.should == "Name"
        column.header.should == "Header"
    end

    it "Should Accept a Block to Get a Value" do
        column = CardColumn.new("Name") { |item| item.property }
        column.value(stub(:property => 5)).should == 5
    end

    it "Should Default to reading the attribute of the same name" do
        column = CardColumn.new("name")

        result = stub(:attributes => {"name" => "Hello"})

        column.value(result).should == "Hello"
    end
end
