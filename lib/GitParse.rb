class GitParse
    def initialize(git_dao, number, regex)
        @git_dao = git_dao
        @number = number
        @regex = regex
    end

    def get_mingle_numbers()
        list = @git_dao.log @number
        matching_commits = list.delete_if{|commit| not commit.message.match @regex}

        return matching_commits.map{|commit| commit.message.match(/\d+/)[0].to_i}
    end
end
