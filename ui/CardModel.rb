class CardModel < Qt::AbstractTableModel
    def initialize(collection,columns)
        super()
        @collection = collection
        @columns = columns
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

        column = @columns[index.column]
        return Qt::Variant.new(column.value(item))
    end

    def headerData(section, orientation=Qt::Horizontal, role=Qt::DisplayRole)
        invalid = Qt::Variant.new
        return invalid unless role == Qt::DisplayRole
        return invalid unless orientation == Qt::Horizontal

        return Qt::Variant.new(@columns[section].header)
    end

    def flags(index)
        return Qt::ItemIsSelectable | Qt::ItemIsEnabled
    end
end
