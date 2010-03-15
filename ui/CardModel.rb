class CardModel < Qt::AbstractTableModel
    def initialize(collection,columns, headers)
        super()
        @collection = collection
        @columns = columns
        @headers = headers
    end

    def rowCount(parent)
        @collection.size
    end

   def columnCount(parent)
        @columns.size
   end

    def data(index, role=Qt::DisplayRole)
        invalid = Qt::Variant.new
        item = @collection[index.row]
        
        return invalid unless role == Qt::DisplayRole
        return invalid if (index.column < 0 || index.column > @columns.size)
        return invalid if item.nil?

        attribute = @columns[index.column]
        return Qt::Variant.new(item.attributes[attribute])
    end

    def headerData(section, orientation=Qt::Horizontal, role=Qt::DisplayRole)
        invalid = Qt::Variant.new
        return invalid unless role == Qt::DisplayRole
        return invalid unless orientation == Qt::Horizontal

        return Qt::Variant.new(@headers[section])
    end

    def flags(index)
        return Qt::ItemIsSelectable | Qt::ItemIsEnabled
    end
end
