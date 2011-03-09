$: << File.dirname(__FILE__) + '/lib'
$: << File.dirname(__FILE__) + '/lib/dao'
$: << File.dirname(__FILE__) + '/ui'

require 'active_resource'
require 'Qt4'

require 'card'
require 'transition'
require 'git_dao'
require 'git_parse'
require 'git_commit_message'
require 'card_model'
require 'card_column'
require 'fetch_cards'
require 'card_table_view'
require 'ruby_variant'

def get_cards(branch)
  git_dao = GitDao.new($folder, branch)
  git_parse = GitParse.new git_dao
  properties = git_parse.get_mingle_numbers
  cards = FetchCards.new.fetch properties
end
