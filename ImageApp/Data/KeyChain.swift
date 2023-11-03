//
//  KeyChain.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 3/11/23.
//

import Foundation
import Security

class KeyChain {
    
    static func save(data: Data, service: String, account: String = "imageapp") -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
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
    
    
}
