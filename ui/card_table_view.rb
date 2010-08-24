class CardTableView < Qt::TableView
    def mousePressEvent(event)
        return unless event.button == Qt::RightButton
        return unless event.type == Qt::Event::MouseButtonPress

        item = get_item_at event.y
        emit rightClickedOn(item.to_variant)
    end

    def mouseMoveEvent(event)
    end

    def mouseDoubleClickEvent(event)
      url = get_item_at(event.y).url
      Qt::DesktopServices.openUrl Qt::Url.new(url)
    end

    signals "rightClickedOn(QVariant)"

  private
    def get_item_at(y_coord)
        model[rowAt(y_coord)]
    end
end
