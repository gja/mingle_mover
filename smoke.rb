$: << File.dirname(__FILE__)
require 'config'
require 'mingle_mover'


Qt::Application.new(ARGV) do
    view_model = CardModel.new(get_cards)

    Qt::MainWindow.new do
        self.centralWidget = CardTableView.new do
            setModel view_model
            resizeColumnsToContents
            setColumnWidth(2, columnWidth(2) / 2)
        end

        self.windowTitle = "Oops, I mingled again!"
        resize 640, 480
        show
    end

    exec
end
