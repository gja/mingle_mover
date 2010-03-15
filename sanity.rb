require 'config'
require 'mingle_mover'

cards = [Card.find(42), Card.find(43)]

Qt::Application.new(ARGV) do
    view_model = CardModel.new(cards, $columns, $headers)

    table = Qt::TableView.new do
        setModel view_model
        show
    end

    exec
end
