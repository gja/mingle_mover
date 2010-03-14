require 'git'

class GitDao
    def initialize(directory)
        @git = Git.open(directory)
    end

    def log(*args)
        return @git.log(*args)
    end
end
