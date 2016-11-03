//
//  OrderedDictionary.swift
//  ContactList
//
//  Created by Nishadh Shrestha on 11/10/15.
//  Copyright © 2015 Nishadh Shrestha. All rights reserved.
//

// Custom dictionary which allows getting back items in the same order it was inserted
public struct OrderedDictionary<Key : Hashable, Value>  {
    // Store the order of keys in this Array
    private var keys: Array<Key> = []
    
    // Store the actual dictionary here
    private var values: Dictionary<Key, Value>= [:]
    
    /// The number of entries in the dictionary.
    ///
    /// - Complexity: O(1).
    public var count: Int {
        get {
            return self.values.count
        }
    }
    
    /// Get value for the given key, or, nil if the key doesn't exist
    subscript(key: Key) -> Value? {
        get {
            return self.values[key]
        }
    }
    
    /// Get value at given index, or, nil if the index is out of bound
    func atIndex(index: Int) -> (key: Key, value: Value)? {
        if 0 <= index && index < self.keys.count {
            let key = self.keys[index]
            return (key, self.values[key]!)
        }
        return nil
    }
    
    /// Update the value stored in the dictionary for the given key, or, if the
    /// key does not exist, add a new key-value pair to the dictionary.
    ///
    /// Returns the value that was replaced, or `nil` if a new key-value pair
    /// was added.
    mutating func updateValue(value: Value, forKey key: Key) -> Value? {
        let oldValue = self.values.updateValue(value, forKey: key)
        if oldValue == nil {
            // Added new key
            keys.append(key)
        }
        return oldValue
    }
    
    /// Remove a given key and the associated value from the dictionary.
    /// Returns the value that was removed, or `nil` if the key was not present
    /// in the dictionary.
    mutating func removeValueForKey(key: Key) -> Value? {
        self.keys = self.keys.filter({$0 != key}) // Remove array item with this key
        
        return self.values.removeValueForKey(key)
    }
    
    /// Release memory for the existing dictionary and allocate new a Dictionary
    mutating func removeAll() {
        self.keys = []
        self.values = [:]
    }
}