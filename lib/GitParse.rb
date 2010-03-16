class GitParse
    def initialize(git_dao, number = $number_of_logs, regex = $pattern)
        @git_dao = git_dao
        @number = number
        @regex = regex
    end

    def get_mingle_numbers()
        list = @git_dao.log @number

        matching_commits = list.delete_if{|commit| not commit.message.match @regex}

        answer = matching_commits.map do |commit| 
            { :number => get_number(commit), :committer => commit.committer.name}
        end

        mapped_cards = []
        answer.delete_if do |property|
            cond = mapped_cards.include? property[:number]
            mapped_cards << property[:number]
            cond
        end
    end

  private
    def get_number(commit)
        commit.message.match(/\d+/)[0].to_i
    end
end
