require 'config'

describe GitParse do
    it "Should Return All Logs Matching A Regular Expression" do
        messages = [stub(:message => "Mailing-#1234 Something Cool"), stub(:message => "Some other string")]
        git_dao = mock()
        git_dao.expects(:log).with(100).returns(messages)

        git_parse = GitParse.new git_dao, 100, /Mailing-#\d*/

        results = git_parse.get_mingle_numbers

        results.should have(1).items
        results[0].should == 1234
    end
end
