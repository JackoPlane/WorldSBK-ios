//
//  ReplayEvent.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import Foundation

public struct ReplayUpdate: Decodable {

    public let name: String
    public let timestamp: Date
    public let updateType: EventUpdateType?
    public let event: ReplayEventUpdate?

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case name = "event"
        case timestamp = "timestamp"
        case event = "args"
    }

    // MARK: - Decoding

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)

        if let type = try? container.decode(EventUpdateType.self, forKey: .name) {
            self.updateType = type

            // Decode event object
            switch updateType {
            case .rider:
                self.event = try container.decode([RiderUpdate].self, forKey: .event).first!
            case .note:
                self.event = (try? container.decode([NoteUpdate].self, forKey: .event))?.first
            case .session:
                self.event = try container.decode([SessionUpdate].self, forKey: .event).first!

//            case .timetable:
//                let args: [Any] = try container.decode(Array<Any>.self, forKey: .event)
//                print("Timetable update: \(args)")
//                self.event = nil

            default:
                self.event = nil
            }
        } else {
            let args: [String: Any] = try container.decode([String: Any].self, forKey: .event)
            print("UNKNOWN TYPE: \(self.name), Args: \(args)")

            self.updateType = nil
            self.event = nil
        }
    }

}
