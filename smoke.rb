$: << File.dirname(__FILE__)
require 'config'
require 'mingle_mover'

git_dao = GitDao.new "."
git_parse = GitParse.new git_dao, $number_of_logs, $pattern

properties = git_parse.get_mingle_numbers

cards = properties.map{|property| Card.find_with_properties(property)}

Qt::Application.new(ARGV) do
    view_model = CardModel.new(cards, $columns)

    table = Qt::TableView.new do
        setModel view_model
        show
    end

    exec
end
