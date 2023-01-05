//
//  File.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import Foundation

public enum RiderBoxState: Int, Codable, CustomStringConvertible {

    case inPits = 1
    case leftPits = 2

    public var description: String {
        switch self {
            case .inPits: return "In pits"
            case .leftPits: return "Out of pits"
        }
    }

}

struct RiderUpdate: ReplayEventUpdate, Codable {

    var type: EventUpdateType = .rider

    let riderNumber: Int
    let currentSection: Int
    let timePassed: Int?
    let boxState: RiderBoxState
    let colour: Int?
    let times: [Int]?

    // MARK: - Enums

    enum RiderUpdateError: Error {
        case decodingError
    }

    enum CodingKeys: String, CodingKey {
        case riderNumber = "nu"
        case currentSection = "pt"
        case timePassed = "tp"
        case boxState = "sb"
        case colour = "cp"
        case times = "tm"
    }


    // MARK: - Decoding

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Rider number is required
        guard let rider = try? container.decode(String.self, forKey: .riderNumber), let riderNumber = Int(rider) else {
            throw RiderUpdateError.decodingError
        }
        self.riderNumber = riderNumber

        // Section is required
        self.currentSection = try container.decode(Int.self, forKey: .currentSection)

        if let boxState = try? container.decodeIfPresent(RiderBoxState.self, forKey: .boxState) {
            self.boxState = boxState
        } else {
            self.boxState = .inPits // Default state is in the pits
        }

        self.timePassed = try? container.decodeIfPresent(Int.self, forKey: .timePassed)
        self.colour = try? container.decodeIfPresent(Int.self, forKey: .colour)
        self.times = try? container.decodeIfPresent([Int].self, forKey: .times)
    }


}
