module stl.container.vector;

/**
 * A standard, generic dynamic array container.
 */
struct Vector(T) {
    private T[] _data;

    void pushBack(T value) {
        _data ~= value;
    }

    @property size_t length() const {
        return _data.length;
    }

    T opIndex(size_t index) {
        return _data[index];
    }
}
