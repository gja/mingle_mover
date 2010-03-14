user = 'tejasd'
password = 'password'
$url = "https://#{user}:#{password}@minglehosting.thoughtworks.com/PROJECTNAME/api/v2/projects/PROJECTSUBPART"
$pattern = /Mingle-#\d+/
$number_of_logs = 100
$git_directory = "."

begin
    require File.dirname(__FILE__) + '/actual_config'
rescue LoadError
end
