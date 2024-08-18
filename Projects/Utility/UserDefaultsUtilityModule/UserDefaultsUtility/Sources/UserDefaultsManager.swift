//
//  UserDefaultsManager.swift
//  UserDefaultsUtility
//
//  Created by DOYEON LEE on 8/17/24.
//

import Foundation

/// A generic manager for securely storing, retrieving, and deleting data in UserDefaults.
/// The data type must conform to `Codable`.
public class UserDefaultsManager<T: UserDefaultsable> {
    
    private let key: String
    
    /// Initializes the UserDefaultsManager with a specific key.
    ///
    /// - Parameter key: The key used to store and retrieve the data.
    public init() {
        self.key = T.key
    }
    
    /// Saves the given item to UserDefaults.
    ///
    /// - Parameter item: The data item of type `T` to be saved, which must conform to `Codable`.
    /// - Returns: A boolean indicating whether the save operation was successful.
    @discardableResult
    public func save(_ item: T) -> Bool {
        do {
            let data = try JSONEncoder().encode(item)
            UserDefaults.standard.set(data, forKey: key)
            return true
        } catch {
            print("Failed to encode item: \(error)")
            return false
        }
    }
    
    /// Retrieves the stored item from UserDefaults.
    ///
    /// - Returns: The stored item of type `T` if it exists, otherwise `nil`.
    public func get() -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            let decodedItem = try JSONDecoder().decode(T.self, from: data)
            return decodedItem
        } catch {
            print("Failed to decode item: \(error)")
            return nil
        }
    }
    
    /// Deletes the stored item from UserDefaults.
    ///
    /// - Returns: A boolean indicating whether the delete operation was successful.
    @discardableResult
    public func delete() -> Bool {
        UserDefaults.standard.removeObject(forKey: key)
        return UserDefaults.standard.object(forKey: key) == nil
    }
}
