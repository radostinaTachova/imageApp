//
//  Image.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 8/11/23.
//

import Foundation

struct ImageItem: Codable {
    let id: String
    let title, description: String?
    let datetime: Int
    let type: String
    let animated: Bool
    let width, height, size, views: Int
    let bandwidth: Int
    let vote: String?
    let favorite: Bool
    let nsfw, section: String?
    let accountURL: String
    let accountID: Int
    let isAd, inMostViral, hasSound: Bool
    let tags: [String]
    let adType: Int
    let adURL, edited: String
    let inGallery: Bool
    let deletehash, name: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case id, title, description, datetime, type, animated, width, height, size, views, bandwidth, vote, favorite, nsfw, section
        case accountURL = "account_url"
        case accountID = "account_id"
        case isAd = "is_ad"
        case inMostViral = "in_most_viral"
        case hasSound = "has_sound"
        case tags
        case adType = "ad_type"
        case adURL = "ad_url"
        case edited
        case inGallery = "in_gallery"
        case deletehash, name, link
    }
}
