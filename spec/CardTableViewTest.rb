require 'config'

describe CardTableView do
    before(:all) do
        @app = Qt::Application.new(ARGV)
    end

    before(:each) do
        cards = [Card.new(:number => 10, :name => "Card10", :status => "Foo"), Card.new(:number => 11, :name => "Card11", :status => "Foo")]
        model = CardModel.new(cards, [stub(:name => "name", :header => "name")], [], [])

        @view = CardTableView.new do
            setModel model
        end
    end

    # This test is to compensate for what I think is a bug in QtRuby
    it "Should Gracefully Handle Clicking on a Cell" do
        @view.mousePressEvent(Qt::MouseEvent.new(Qt::Event::MouseButtonPress, Qt::Point.new(0,0), Qt::LeftButton, Qt::LeftButton, Qt::NoModifier))
        @view.mouseMoveEvent(Qt::MouseEvent.new(Qt::Event::MouseMove, Qt::Point.new(0,0), Qt::LeftButton, Qt::LeftButton, Qt::NoModifier))
    end


    after(:all) do
        @app.dispose
    end
end
