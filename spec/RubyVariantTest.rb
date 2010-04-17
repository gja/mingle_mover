require 'config'

describe Qt::RubyVariant do
    before(:each) do
        @object = Object.new
        def @object.foo
            "bar"
        end
    end

    it "Should Be Possible to Convert to a Variant" do
        var = @object.to_variant
        var.should be_a Qt::Variant
        var.value.foo.should == "bar"
    end
end
