require 'config'

describe CardTableView do
    before(:each) do
        cards = [Card.new(:number => 10, :name => "Card10", :status => "Foo"), Card.new(:number => 11, :name => "Card11", :status => "Foo")]
        model = CardModel.new(cards, [stub(:name => "name", :header => "name")], [], [])

        @view = CardTableView.new do
            setModel model
        end

        @row1 = @view.rowViewportPosition 0
        @row2 = @view.rowViewportPosition 1
    end

    it "Should Gracefully Handle Clicking on a Cell" do
        @view.mousePressEvent(Qt::MouseEvent.new(Qt::Event::MouseButtonPress, Qt::Point.new(0,0), Qt::LeftButton, Qt::LeftButton, Qt::NoModifier))
        @view.mouseMoveEvent(Qt::MouseEvent.new(Qt::Event::MouseMove, Qt::Point.new(0,0), Qt::LeftButton, Qt::LeftButton, Qt::NoModifier))
    end

    it "Should Get a signal to display context menu on right click" do
        @view.should emit_signal_on_mouse_press(Qt::RightButton, Qt::Point.new(0, @row2), 11)
        @view.should emit_signal_on_mouse_press(Qt::RightButton, Qt::Point.new(0, @row1), 10)
    end

    it "Should Ignore Other Mouse Events" do
        @view.should ignore_mouse_press(Qt::LeftButton, Qt::Point.new(0, @row1))
        @view.should ignore_mouse_press(Qt::RightButton, Qt::Point.new(0, @row1), Qt::Event::MouseButtonRelease)
    end

    it "Should Launch a Url on double click" do
        Card.any_instance.stubs(:url).returns("http://google.com")
        Qt::DesktopServices.expects(:openUrl).with(){|url| url.to_string == "http://google.com" }
        @view.mouseDoubleClickEvent(Qt::MouseEvent.new(Qt::Event::MouseButtonPress, Qt::Point.new(0,@row1), Qt::LeftButton, Qt::LeftButton, Qt::NoModifier))
    end
 
    def ignore_mouse_press(button, point, event = Qt::Event::MouseButtonPress)
        return simple_matcher("An object not responding to click of " + button.to_s) do |given|
            assert_on_signal_after_mouse_event(given, button, point, event) { |c| c.should be_nil }
        end
    end

    def emit_signal_on_mouse_press(button, point, value)
        return simple_matcher(value.to_s + " when " + button.to_s + " is pressed at " + point.y.to_s) do |given|
            assert_on_signal_after_mouse_event(given, button, point) { |c| c.to_object.number.should == value }
        end
    end

    def assert_on_signal_after_mouse_event(given, button, point, event = Qt::Event::MouseButtonPress)
        spy = RubySignalSpy.create do
          slots "recieved(QVariant)"
        end

        Qt::Object.connect(given, SIGNAL('rightClickedOn(QVariant)'), spy, SLOT('recieved(QVariant)'))

        given.mousePressEvent(Qt::MouseEvent.new(event, point, button, button, Qt::NoModifier))
        called = spy.params(:recieved, 0) || [nil]
        yield called[0]
    end
end
