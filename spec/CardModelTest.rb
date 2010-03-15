require 'config'

describe CardModel do
    before do
        cards = [Card.new(:id => 1, :name => "name1", :status => "In Progress"),
                    Card.new(:id => 2, :name => "name2", :status => "In Progress")]

        columns = ["id", "name"]
        headers = ["Card Number", "Card Name"]

        @model = CardModel.new cards, columns, headers
    end

    it "Should Implement QAbstractTableModel" do
        CardModel.ancestors.should include Qt::AbstractTableModel
    end

    it "Should Hold On To A List Of Cards" do
        @model.rowCount(nil).should == 2
    end

    it "Should Contain A List of Columns" do
        @model.columnCount(nil).should == 2
    end

    it "Should Return Invalid if Row or Column is out of bounds" do
        @model.data(mock_index(10, 0)).should_not be_valid
        @model.data(mock_index(0, 10)).should_not be_valid
        @model.data(mock_index(0, -1)).should_not be_valid
    end

    it "Should Return Data If Present" do
        data = @model.data(mock_index(0, 1))
        data.should be_valid
        data.toString.should == "name1"

        @model.data(mock_index(1,0)).toInt.should == 2
    end

    it "Should Not Be Editable" do
        @model.data(mock_index(1,2), Qt::EditRole).should_not be_valid
        @model.headerData(nil, nil, Qt::EditRole).should_not be_valid
        
        flags = @model.flags(nil)
        flags.should have_flag Qt::ItemIsSelectable
        flags.should_not have_flag Qt::ItemIsEditable
        flags.should have_flag Qt::ItemIsEnabled
    end

    it "Should Return Headers" do
        @model.headerData(1).toString.should == "Card Name"
    end

    def mock_index(row, col)
        stub(:row => row, :column => col);
    end

    def have_flag(flag)
        return simple_matcher("Have Flag Set") { |given| (given & flag) != 0 }
    end
end
