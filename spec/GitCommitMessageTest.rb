require 'config'

describe GitCommitMessage do
    it "Should Return All Logs Matching A Regular Expression" do
      commit = GitCommitMessage.new "Tejas Dinkar////Something cool I did"
      commit.committer.name.should == "Tejas Dinkar"
      commit.message.should == "Something cool I did"
    end
end
