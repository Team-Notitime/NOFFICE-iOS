//
//  KeychainManager.swift
//  KeychainUtility
//
//  Created by DOYEON LEE on 8/15/24.
//

import Foundation
import Security

/// A generic manager for securely storing, retrieving, and deleting data in the Keychain.
/// The data type must conform to `Codable`.
///
/// Example usage:
/// ```swift
/// struct Token: Codable {
///     let accessToken: String
///     let refreshToken: String
/// }
///
/// let keychainManager = KeychainManager<Token>()
///
/// let token = UserToken(accessToken: "yourAccessToken", refreshToken: "yourRefreshToken")
///
/// // Save token
/// let saveSuccess = keychainManager.save(token)
/// print("Token saved successfully: \(saveSuccess)")
///
/// // Retrieve token
/// if let retrievedToken = keychainManager.get() {
///     print("Retrieved token: \(retrievedToken)")
/// }
///
/// // Delete token
/// let deleteSuccess = keychainManager.delete()
/// print("Token deleted successfully: \(deleteSuccess)")
/// ```
public class KeychainManager<T: Keychainable> {
    
    private let service: String
    private let account: String

    /// Initializes the KeychainManager with a specific service and account.
    public init() {
        self.service = Bundle.main.bundleIdentifier ?? ""
        self.account = T.account
    }

    /// Saves the given item to the Keychain. If the item already exists, it updates the existing item.
    ///
    /// - Parameter item: The data item of type `T` to be saved, which must conform to `Codable`.
    /// - Returns: A boolean indicating whether the save operation was successful.
    @discardableResult
    public func save(_ item: T) -> Bool {
        do {
            let data = try JSONEncoder().encode(item)
            if let _ = get() {
                // If data already exists, update it
                let query: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrService as String: service,
                    kSecAttrAccount as String: account
                ]
                let attributes: [String: Any] = [
                    kSecValueData as String: data
                ]
                let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
                return status == errSecSuccess
            } else {
                // If no data exists, create a new entry
                let query: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrService as String: service,
                    kSecAttrAccount as String: account,
                    kSecValueData as String: data
                ]
                let status = SecItemAdd(query as CFDictionary, nil)
                return status == errSecSuccess
            }
        } catch {
            print("Failed to encode item: \(error)")
            return false
        }
    }

    /// Retrieves the stored item from the Keychain.
    ///
    /// - Returns: The stored item of type `T` if it exists, otherwise `nil`.
    public func get() -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess, let data = item as? Data else { return nil }

        do {
            let decodedItem = try JSONDecoder().decode(T.self, from: data)
            return decodedItem
        } catch {
            print("Failed to decode item: \(error)")
            return nil
        }
    }

    /// Deletes the stored item from the Keychain.
    ///
    /// - Returns: A boolean indicating whether the delete operation was successful.
    @discardableResult
    public func delete() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
