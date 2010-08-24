class GitDao
    def initialize(directory)
    end

    def log(*args)
      number = args[0] || 100
      messages = `git log -n #{number} --pretty=format:%an////%s`.split("\n")
      messages.collect!{|message| GitCommitMessage.new message}
    end
end
