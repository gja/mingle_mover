class Object
    def to_variant
        Qt::Variant.new object_id
    end
end

class Qt::Variant
    def to_object
        ObjectSpace._id2ref to_int
    end
end
