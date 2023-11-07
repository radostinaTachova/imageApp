//
//  KeyChain.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 3/11/23.
//

import Foundation
import Security

class KeyChainHelper {
    
    static func save(data: Data, service: String, account: String = "imageapp") -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        let status = SecItemAdd(query as CFDictionary, nil)

        //TODO: remove
        if status == errSecDuplicateItem {
            print("RTC = duplicate item")
        }
        
        return status == errSecSuccess
    }
    
    
    static func retrieve(service: String, account: String = "imageapp") -> Data? {
        let query = [
              kSecAttrService: service,
              kSecAttrAccount: account,
              kSecClass: kSecClassGenericPassword,
              kSecReturnData: true
          ] as CFDictionary
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status == errSecSuccess else { return nil }
        return (item as? Data)
    }
    
    
    static func delete(service: String, account: String = "imageapp") -> Bool {
        let query = [
              kSecAttrService: service,
              kSecAttrAccount: account,
              kSecClass: kSecClassGenericPassword,
          ] as CFDictionary
        
        let status = SecItemDelete(query as CFDictionary)
        print("RTC == delete \(service) , success = \(status == errSecSuccess), notFound = \(status == errSecItemNotFound)")
        return (status == errSecSuccess)
        
    }

    
    
}
