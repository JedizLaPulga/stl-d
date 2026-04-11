module stl.container.vector;

import core.exception : RangeError;
import std.algorithm.mutation : remove;
import std.array : insertInPlace;

/**
 * A standard, generic dynamic array container.
 * Provides C++ STL-like Vector capabilities while remaining idiomatically D.
 */
struct Vector(T) {
    private T[] _data;

    /// Constructor allocating initial capacity
    this(size_t initialCapacity) {
        reserve(initialCapacity);
    }

    /// Appends an element to the back
    void pushBack(T value) {
        _data ~= value;
    }

    /// Removes the last element
    void popBack() {
        if (!empty) {
            _data.length -= 1;
            assumeSafeAppend(_data);
        }
    }

    /// Number of elements currently in the vector
    @property size_t length() const {
        return _data.length;
    }

    /// Is the vector empty?
    @property bool empty() const {
        return _data.length == 0;
    }

    /// Clears all elements
    void clear() {
        _data.length = 0;
        assumeSafeAppend(_data);
    }

    /// Current capacity before a new allocation is needed
    @property size_t capacity() const {
        return _data.capacity;
    }

    /// Reserves memory for at least `newCapacity` elements
    void reserve(size_t newCapacity) {
        _data.reserve(newCapacity);
    }

    /// Shrinks the internal capacity to fit the current length
    void shrinkToFit() {
        if (_data.capacity > _data.length) {
             // Create a new perfectly-sized slice to drop excess capacity
            T[] newData;
            newData.reserve(_data.length);
            newData ~= _data;
            _data = newData;
        }
    }

    /// Unchecked index access (operator [])
    ref T opIndex(size_t index) {
        return _data[index];
    }

    /// Checked index access
    ref T at(size_t index) {
        if (index >= _data.length) {
            throw new RangeError("Vector.at: Index out of bounds");
        }
        return _data[index];
    }

    /// Returns a reference to the first element
    ref T front() {
        if (empty) throw new RangeError("Vector.front: Vector is empty");
        return _data[0];
    }

    /// Returns a reference to the last element
    ref T back() {
        if (empty) throw new RangeError("Vector.back: Vector is empty");
        return _data[$-1];
    }

    /// Inserts an element at a specific index
    void insert(size_t index, T value) {
        if (index >= _data.length) {
            pushBack(value);
        } else {
            insertInPlace(_data, index, value);
        }
    }

    /// Erases an element at a specific index
    void erase(size_t index) {
        if (index < _data.length) {
            _data = _data.remove(index);
            assumeSafeAppend(_data);
        }
    }

    /// Provides slice access `vec[]` to interact with D's range system easily
    T[] opSlice() {
        return _data;
    }

    /// Slice boundaries (allows vec[0..2])
    T[] opSlice(size_t start, size_t end) {
        return _data[start .. end];
    }
    
    /// Internal structure length for $ operator
    @property size_t opDollar() const {
        return _data.length;
    }

    /// Seamless `foreach` iteration
    int opApply(scope int delegate(ref T) dg) {
        int result = 0;
        foreach (ref e; _data) {
            result = dg(e);
            if (result) break;
        }
        return result;
    }

    /// Seamless `foreach` iteration with index
    int opApply(scope int delegate(size_t i, ref T e) dg) {
        int result = 0;
        foreach (i, ref e; _data) {
            result = dg(i, e);
            if (result) break;
        }
        return result;
    }
}

// ===========================================================================
// Unit Tests
// ===========================================================================
unittest {
    Vector!int vec;
    
    // Test pushBack and basic access
    vec.pushBack(10);
    vec.pushBack(20);
    vec.pushBack(30);
    assert(vec.length == 3);
    assert(vec.front == 10);
    assert(vec.back == 30);
    assert(vec[1] == 20);
    assert(vec.at(1) == 20);

    // Test popBack
    vec.popBack();
    assert(vec.length == 2);
    assert(vec.back == 20);

    // Test insert
    vec.insert(1, 15);
    assert(vec[1] == 15);
    assert(vec.length == 3);

    // Test erase
    vec.erase(1);
    assert(vec[1] == 20);
    assert(vec.length == 2);

    // Test iteration
    int sum = 0;
    foreach(val; vec) {
        sum += val;
    }
    assert(sum == 30); // 10 + 20

    // Test capacity & reserve
    vec.reserve(100);
    assert(vec.capacity >= 100);
    
    // Test clear
    vec.clear();
    assert(vec.empty);
    assert(vec.length == 0);
}
