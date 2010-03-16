require 'config'

describe CardModel do
    before do
        cards = [Card.new(:id => 1, :name => "name1", :status => "Good"),
                    Card.new(:id => 2, :name => "name2", :status => "Ugly")]

        columns = [CardColumn.new("id", "Card Number"), CardColumn.new("name", "Card Name"), CardColumn.new("status")]

        @model = CardModel.new cards, columns, ["Good"], ["Ugly"]
    end

    it "Should Implement QAbstractTableModel" do
        CardModel.ancestors.should include Qt::AbstractTableModel
    end

    it "Should Hold On To A List Of Cards" do
        @model.rowCount(nil).should == 2
    end

    it "Should Contain A List of Columns" do
        @model.columnCount(nil).should == 3
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
        flags.should have_flag Qt::ItemIsEnabled
        flags.should have_flag Qt::ItemIsSelectable
        flags.should_not have_flag Qt::ItemIsEditable
    end

    it "Should Return Headers" do
        @model.headerData(1).toString.should == "Card Name"
    end

    it "Should not return any vertical headers" do
        @model.headerData(1, Qt::Vertical).should_not be_valid
    end

    it "Should color a row according to the status" do
        @model.data(mock_index(1,2), Qt::ForegroundRole).value.should == Qt::Color.new(Qt::red)
        @model.data(mock_index(0,2), Qt::ForegroundRole).value.should == Qt::Color.new(Qt::green)
        @model.data(mock_index(0,0), Qt::ForegroundRole).should_not be_valid
    end

    def mock_index(row, col)
        stub(:row => row, :column => col);
    end

    def have_flag(flag)
        return simple_matcher("A flag that matches " + flag.to_s) { |given| (given & flag) != 0 }
    end
end
