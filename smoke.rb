require 'config'
require 'mingle_mover'

git_dao = GitDao.new "."
git_parse = GitParse.new git_dao, $number_of_logs, $pattern

numbers = git_parse.get_mingle_numbers

cards = numbers.map{|number| Card.find(number)}

Qt::Application.new(ARGV) do
    view_model = CardModel.new(cards, $columns)

    table = Qt::TableView.new do
        setModel view_model
        show
    end

    exec
end
