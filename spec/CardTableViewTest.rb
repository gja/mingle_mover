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

    it "Should Gracefully Handle Clicking on a Cell" do
        @view.mousePressEvent(Qt::MouseEvent.new(Qt::Event::MouseButtonPress, Qt::Point.new(0,0), Qt::LeftButton, Qt::LeftButton, Qt::NoModifier))
        @view.mouseMoveEvent(Qt::MouseEvent.new(Qt::Event::MouseMove, Qt::Point.new(0,0), Qt::LeftButton, Qt::LeftButton, Qt::NoModifier))
    end

    it "Should Get a signal to display context menu on right click" do
        x0 = @view.rowViewportPosition 0
        x1 = @view.rowViewportPosition 1

        @view.should emit_signal_on_mouse_press(Qt::LeftButton, Qt::Point.new(0, x1), nil)
        @view.should emit_signal_on_mouse_press(Qt::RightButton, Qt::Point.new(0, x1), 11)
        @view.should emit_signal_on_mouse_press(Qt::RightButton, Qt::Point.new(0, x0), 10)
    end

    def emit_signal_on_mouse_press(button, point, value)
        return simple_matcher(value.to_s + " when " + button.to_s + " is pressed at " + point.y.to_s) do |given|
            called = nil
            given.connect(SIGNAL('rightClickedOn(int)')) do |g|
                called = g
            end

            given.mousePressEvent(Qt::MouseEvent.new(Qt::Event::MouseButtonPress, point, button, button, Qt::NoModifier))
            called.should == value
        end
    end

    after(:all) do
        @app.dispose
    end
end
