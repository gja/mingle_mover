user = 'tejasd'
password = 'password'
$url = "https://#{user}:#{password}@minglehosting.thoughtworks.com/PROJECTNAME/api/v2/projects/PROJECTSUBPART"
$pattern = /Mingle-#\d+/
$number_of_logs = 100
$git_directory = "."

require File.dirname(__FILE__) + '/ui/CardColumn'
$columns = [CardColumn.new("number", "Number"), 
            CardColumn.new("committer", "Committer") {|item| item.committer},
            CardColumn.new("name", "Name"),
            CardColumn.new("Status") {|item| item.status}]

$good_status = ["QA Closed", "Ready for QA", "In QA", "Available in UAT", "Ready for Acceptance", "Accepted"]
$bad_status = ["In Dev", "In Development"]
$ugly_status = ["Open", "Ready for Development"]

begin
    require File.dirname(__FILE__) + '/actual_config'
rescue LoadError
end
