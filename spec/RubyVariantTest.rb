require 'config'

describe Qt::Variant do
    before(:each) do
        @object = Object.new
        def @object.foo
            "bar"
        end
    end

    it "Should Be Possible to Convert to a Variant" do
        var = @object.to_variant
        var.should be_a Qt::Variant
        var.to_object.foo.should == "bar"
    end

    it "Should Be Possible to Emit a Ruby Class" do
        variant = @object.to_variant
        app = Qt::Application.new(ARGV) do
            spy = Qt::SignalSpy.new
            Qt::Object.connect(spy, SIGNAL('signal(QVariant)'), spy, SLOT('receive(QVariant)'))
            spy.emit(variant)
            spy.received.foo.should == "bar"
        end
    end
end

class Qt::SignalSpy < Qt::Object
    signals 'signal(QVariant)'
    def emit(object)
        super signal(object)
    end

    slots 'receive(QVariant)'
    def receive(object)
        @received = object.to_object
    end

    attr_accessor :received
end
