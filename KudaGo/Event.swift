//
//  Event.swift
//  KudaGo
//
//  Created by Николаев Никита on 14.01.2021.
//

import Foundation

struct EventsResponse: Codable {
    let results: [Event]?
}

struct Event: Codable {
    let title, description, bodyText: String?
    let images: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case bodyText = "body_text"
        case images
    }
}

struct Image: Codable {
    let image: String?
}
