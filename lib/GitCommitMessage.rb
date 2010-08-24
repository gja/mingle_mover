class GitCommitMessage
  def initialize(separated_message)
    tokens = separated_message.split "////"
    @committer = GitCommitter.new(tokens[0])
    @message = tokens[1]
  end

  attr_reader :committer, :message
end

class GitCommitter
  def initialize(name)
    @name = name
  end

  attr_reader :name
end
