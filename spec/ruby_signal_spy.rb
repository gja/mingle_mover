class RubySignalSpy < Qt::Object
    def self.create(*args, &block)
        Class.new(self).new(*args, &block)
    end

    def count(name)
        @calls[name].size
    end

    def params(name, invocation = 0)
        @calls[name][invocation]
    end

    def method_missing(name, *args, &block)
        @calls[name.to_sym] << args
        exec_action_for(name.to_sym, args)
    end

    def responds_to?(name)
        true
    end

  private
    def initialize
        @calls = {}
        def @calls.[](index)
            super || self[index] = []
        end
        @actions = {}
        super
    end

    def mocked_slots(*names, &block)
        slots *names
        names.each { |name| @actions[name] = block }
    end

    def exec_action_for(name, args)
        @actions[name].call(self, args) if @actions[name]
    end

    def slots(*args)
        self.class.slots(*args)
    end
end
