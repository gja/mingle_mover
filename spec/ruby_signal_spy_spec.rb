describe RubySignalSpy do
    it "Should Provide Methods For All Mocked Slots" do
        mocked = RubySignalSpy.new do
            slots :foo, :bar
        end
        
        mocked.foo
        mocked.foo
        mocked.bar

        mocked.count(:foo).should == 2
        mocked.count(:bar).should == 1
    end

    it "Should Store the Parameters Passed" do
        mocked = RubySignalSpy.new do
            slots :foo
        end

        mocked.foo(42)
        mocked.foo("bar", "baz")

        mocked.params(:foo).should == [42]
        mocked.params(:foo, 1).should == ["bar", "baz"]
    end

    it "Should be able to execute a block" do
        a = 0

        mocked = RubySignalSpy.create do
            mocked_slots :foo, :bar do |obj, params|
                obj.should == mocked
                params.should == [1, 2]
                a = a+1
            end
        end

        mocked.foo(1, 2)
        mocked.bar(1, 2)
        a.should == 2
        mocked.count(:foo).should == 1
        mocked.count(:bar).should == 1
    end

    it "Should be able to emit a signal when called" do
        reciever = RubySignalSpy.create do
            slots "recieved(int, int)"                      # Explicitly name slots with parameters
            mocked_slot :some_other_slot do |spy, params|   # Pass a block to be executed when called
            end                                             # You must call mocked_slot with a symbol
        end

        class Sender < Qt::Object
            signals "sending(int, int)"
            def broadcast
                emit sending(4, 2)
            end
        end

        sender = Sender.new

        Qt::Object.connect(sender, SIGNAL("sending(int, int)"), reciever, SLOT("recieved(int, int)"))
        sender.broadcast
        reciever.count(:recieved).should == 1               # Get count of calls
        reciever.params(:recieved, 0).should == [4, 2]      # Get the parameters of nth invocation
    end
end
