class CardModel < Qt::AbstractTableModel
    def initialize(collection,columns = $columns, good = $good_status, ugly = $ugly_status)
        super()
        @collection = collection
        @columns = columns
        @good = good
        @ugly = ugly
    end

    def rowCount(parent)
        @collection.size
    end

   def columnCount(parent)
        @columns.size
   end

    def data(index, role=Qt::DisplayRole)
        item = @collection[index.row]
        
        return invalid if (index.column < 0 || index.column > @columns.size)
        return invalid if item.nil?

        return Qt::Variant.new(get_value(index, item)) if role == Qt::DisplayRole
        return get_color(index, item) if role == Qt::ForegroundRole

        return invalid
    end

    def headerData(section, orientation=Qt::Horizontal, role=Qt::DisplayRole)
        return invalid unless role == Qt::DisplayRole
        return invalid unless orientation == Qt::Horizontal

        return Qt::Variant.new(@columns[section].header)
    end

    def flags(index)
        return Qt::ItemIsSelectable | Qt::ItemIsEnabled
    end

  private
    def get_value(index, item)
        @columns[index.column].value(item)
    end

    def get_color(index, item)
        value = get_value(index, item)

        return Qt::Variant.new(Qt::red) if @ugly.include? value
        return Qt::Variant.new(Qt::green) if @good.include? value

        return invalid
    end

    def invalid
        Qt::Variant.new
    end
end
