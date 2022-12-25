//
//  NoteUpdate.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import Foundation

struct NoteUpdate: ReplayEventUpdate, Decodable {

    var type: EventUpdateType = .note

    let pageName: String? // Not used, appears to provide the CSS class name for styling?
    let message: String
    //let publishedDate: Date?

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case pageName = "NomePaginaApiController"
        case message = "de"
        //case publishedDate = "or"
    }

}
