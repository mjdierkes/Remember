//
//  VolumeInfo.swift
//  Remember
//
//  Created by Mason Dierkes on 12/2/22.
//

import Foundation

struct SearchResult: Codable {
    let kind: String
    let totalItems: Int
    let items: [Book]
}

struct Book: Codable, Identifiable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let publishedDate: String
    let description: String?
    let industryIdentifiers: [Identifier]
    let imageLinks: Links
}

struct Identifier: Codable {
    let type: String
    let identifier: String
}

struct Links: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
    let small: String?
    let medium: String?
    let large: String?
}
