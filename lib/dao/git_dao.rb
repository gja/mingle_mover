class GitDao
    def initialize(directory, branch = '')
      @directory = directory
      @branch = branch
    end

    def log(*args)
      old_dir = Dir.pwd
      number = args[0] || 100
      Dir.chdir(@directory)
      messages = `git log -n #{number} --pretty=format:%an////%s #{@branch}`.split("\n")
      Dir.chdir(old_dir)
      messages.collect!{|message| GitCommitMessage.new message}
    end
end
