import std.stdio : writeln;
import stl; // This pulls in everything you've exposed in package.d (e.g., Vector)

void main() {
    writeln("--- stl-d Vector Example ---");

    // Initialize the Vector purely in D
    Vector!int vec;
    
    // Add some elements
    vec.pushBack(10);
    vec.pushBack(20);
    vec.pushBack(30);
    writeln("After pushBack: ", vec[]);

    // Change an element with bracket notation
    vec[1] = 99;
    writeln("After modifying vec[1]: ", vec[]);

    // Insert an element
    vec.insert(1, 55);
    writeln("After inserting 55 at index 1: ", vec[]);
    
    // Iterate beautifully with foreach (uses opApply/opSlice)
    int sum = 0;
    foreach(val; vec) {
        sum += val;
    }
    writeln("Sum of elements: ", sum);

    // Erase an element
    vec.erase(1);
    writeln("After erasing index 1: ", vec[]);
    
    // Check state methods
    writeln("Is vector empty? ", vec.empty);
    writeln("Vector front: ", vec.front);
    writeln("Vector back: ", vec.back);

    // Pop the back
    vec.popBack();
    writeln("After popBack: ", vec[]);

    // Clear everything
    vec.clear();
    writeln("After clear, empty? ", vec.empty);
}
