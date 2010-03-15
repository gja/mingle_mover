class GitDao
    def initialize(directory)
        @git = Git.open(directory)
    end

    def log(*args)
        @git.log(*args).to_a
    end
end
