class CardTableView < Qt::TableView
    def mousePressEvent(event)
        return unless event.button == Qt::RightButton
        item = model[rowAt(event.y)]
        emit rightClickedOn(item.number)
    end

    def mouseMoveEvent(event)
    end

    signals "rightClickedOn(int)"
end
