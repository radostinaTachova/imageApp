//
//  Result.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 8/11/23.
//

import Foundation

// MARK: - Result
struct Result<Item: Codable>: Codable {
    let data: Item
    let success: Bool
    let status: Int
}


