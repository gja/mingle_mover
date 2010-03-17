require 'config'

describe CardTableView do
    before(:all) do
        @app = Qt::Application.new(ARGV)
    end

    before(:each) do
        @view = CardTableView.new
    end

    # This test is to compensate for what I think is a bug in QtRuby
    it "Should Gracefully Handle Clicking on a Cell" do
        @view.mousePressEvent(nil)
        @view.mouseMoveEvent(nil)
    end

    after(:all) do
        @app.dispose
    end
end
