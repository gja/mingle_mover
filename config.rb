user = 'tejasd'
password = 'password'
$mingle_instance = "https://#{user}:#{password}@minglehosting.thoughtworks.com/INSTANCE"
$mingle_instance = "https://minglehosting.thoughtworks.com/INSTANCE"
$project_name = "PROJECTNAME"
$url = "#{$mingle_instance}/api/v2/projects/#{$project_name}"
$pattern = /Mingle-#\d+/
$number_of_logs = 100
$folder = "."

require File.dirname(__FILE__) + '/ui/card_column'
$columns = [CardColumn.new("number", "Number"), 
            CardColumn.new("committer", "Committer") {|item| item.committer},
            CardColumn.new("name", "Name"),
            CardColumn.new("Status") {|item| item.status}]

$good_status = ["QA Closed", "Ready for QA", "In QA", "Available in UAT", "Ready for Acceptance", "Accepted", "Ready for Showcase"]
$bad_status = ["In Dev", "In Development"]
$ugly_status = ["Open", "Ready for Development"]

begin
    require File.dirname(__FILE__) + '/actual_config'
rescue LoadError
end
