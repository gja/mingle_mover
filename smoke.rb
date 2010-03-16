$: << File.dirname(__FILE__)
require 'config'
require 'mingle_mover'

git_dao = GitDao.new "."
git_parse = GitParse.new git_dao

properties = git_parse.get_mingle_numbers

cards = FetchCards.new.fetch properties

Qt::Application.new(ARGV) do
    view_model = CardModel.new(cards)

    table = Qt::TableView.new do
        setModel view_model
        show
    end

    exec
end
