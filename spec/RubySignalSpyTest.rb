require 'active_resource'
require 'Qt4'

class RubySignalSpy < Qt::Object
    def initialize
        @calls = {}
        @actions = {}
        super
    end

    def mocked_slot(name, &block)
        Qt::Object::slots "#{name}()"
        
        @calls[name] = []
        @actions[name] = block
        eval <<-eos
            def #{name}(*params)
                @calls[:#{name}] << params
                exec_action_for(:#{name})
            end
        eos
    end

    def exec_action_for(name)
        instance_eval &(@actions[name]) if @actions[name]
    end

    def count(name)
        @calls[name].size
    end

    def params(name, invocation = 1)
        @calls[name][invocation -1]
    end

    def mocked_slots(*args)
        args.each { |arg| mocked_slot arg }
    end

    def signals(*args)
        self.class.signals(*args)
    end
end

describe RubySignalSpy do
    before(:all) do
        @app = Qt::Application.new(ARGV)
    end

    it "Should Provide Methods For All Mocked Slots" do
        mocked = RubySignalSpy.new do
            mocked_slots :foo, :bar
        end
        
        mocked.foo
        mocked.foo
        mocked.bar

        mocked.count(:foo).should == 2
        mocked.count(:bar).should == 1
    end

    it "Should Store the Parameters Passed" do
        mocked = RubySignalSpy.new do
            mocked_slots :foo
        end

        mocked.foo(42)
        mocked.foo("bar", "baz")

        mocked.params(:foo).should == [42]
        mocked.params(:foo, 2).should == ["bar", "baz"]
    end

    it "Should be able to emit a signal when called" do
        class Reciever < RubySignalSpy
            mocked_slots :revieved
        end

        reciever = Reciever.new

        sender = RubySignalSpy.new do
            signals "sending()"
            mocked_slot :send do
                emit "sending()"
            end
        end

        Qt::Object.connect(sender, SIGNAL(:sending), reciever, SLOT(:recieved))

        sender.send

        reciever.count(:recieved).should == 1
    end

    after(:all) do
        @app.dispose
    end
end

