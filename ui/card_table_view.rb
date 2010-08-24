class CardTableView < Qt::TableView
    def mousePressEvent(event)
        return unless event.button == Qt::RightButton
        return unless event.type == Qt::Event::MouseButtonPress

        item = model[rowAt(event.y)]
        emit rightClickedOn(item.to_variant)
    end

    def mouseMoveEvent(event)
    end

    signals "rightClickedOn(QVariant)"
end
