//
//  Image.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 8/11/23.
//

import Foundation

struct ImageUIItem: Identifiable, Equatable {
    let id: String
    let url: String
    let title: String
    let deleteHash: String?
}
