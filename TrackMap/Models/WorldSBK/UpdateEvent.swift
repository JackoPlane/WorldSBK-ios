//
//  UpdateEvent.swift
//  TrackMap
//
//  Created by Jack Perry on 27/12/2022.
//

import Foundation

enum HubEvent: Codable {

    /// Competitors update (Event name: `updateConduttori`)
    case competitors([CompetitorUpdate], timestamp: Date)

    /// Note update (Event name: `updateNota`)
    case note(NoteUpdate, timestamp: Date)

    /// Session update, (Event name: `updateDurataSessione`)
    case session(SessionUpdate, timestamp: Date)

    /// Event update (Event name: `updateEvento`)
    case event(EventUpdate, timestamp: Date)

    /// Rider/track position position update (Event name: `RiderUpdate`)
    case rider(RiderUpdate, timestamp: Date)

    // Results (Event name: `updateRisultati`)
    case results([ResultUpdate], timestamp: Date)

    /// Timetable update (Event name: `updateProgrammaOrario`)
    case timetable([TimetableUpdate], timestamp: Date)

    case unsupported(_ name: String)

    // MARK: - Codable

    private enum CodingKeys: String, CodingKey {
        case type = "event"
        case payload = "args"
        case timestamp = "timestamp"
    }

    // MARK: - Decoding

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        let timestamp = try container.decode(Date.self, forKey: .timestamp)

        switch type {
        case "updateConduttori":
            let payload = try container.decode([[CompetitorUpdate]].self, forKey: .payload).first?.compactMap { $0 }
            self = .competitors(payload ?? [], timestamp: timestamp)

        case "updateNota":
            guard let payload = try? container.decode([NoteUpdate].self, forKey: .payload).first else {
                self = .unsupported(type)
                return
            }

            self = .note(payload, timestamp: timestamp)

        case "updateDurataSessione":
            guard let payload = try? container.decode([SessionUpdate].self, forKey: .payload).first else {
                self = .unsupported(type)
                return
            }
            self = .session(payload, timestamp: timestamp)

        case "updateEvento":
            guard let payload = try? container.decode([EventUpdate].self, forKey: .payload).first else {
                self = .unsupported(type)
                return
            }
            self = .event(payload, timestamp: timestamp)

        case "updatePassaggio":
            guard let payload = try? container.decode([RiderUpdate].self, forKey: .payload).first else {
                self = .unsupported(type)
                return
            }
            self = .rider(payload, timestamp: timestamp)

        case "updateRisultati":
            guard let payload = try? container.decode([[ResultUpdate]].self, forKey: .payload).first else {
                self = .unsupported(type)
                return
            }
            self = .results(payload, timestamp: timestamp)

        case "updateProgrammaOrario":
            guard let payload = try? container.decode([[TimetableUpdate]].self, forKey: .payload).first else {
                self = .unsupported(type)
                return
            }
            self = .timetable(payload, timestamp: timestamp)


        default:
            self = .unsupported(type)
        }
    }

    // MARK: - Encoding

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .competitors(let competitors, let timestamp):
            try container.encode("updateConduttori", forKey: .type)
            try container.encode([[competitors]], forKey: .payload)
            try container.encode(timestamp, forKey: .timestamp)

        case .note(let note, let timestamp):
            try container.encode("updateNota", forKey: .type)
            try container.encode([note], forKey: .payload)
            try container.encode(timestamp, forKey: .timestamp)

        case .session(let session, let timestamp):
            try container.encode("updateDurataSessione", forKey: .type)
            try container.encode([session], forKey: .payload)
            try container.encode(timestamp, forKey: .timestamp)

        case .event(let event, let timestamp):
            try container.encode("updateEvento", forKey: .type)
            try container.encode([event], forKey: .payload)
            try container.encode(timestamp, forKey: .timestamp)

        case .rider(let rider, let timestamp):
            try container.encode("updatePassaggio", forKey: .type)
            try container.encode([rider], forKey: .payload)
            try container.encode(timestamp, forKey: .timestamp)

        case .results(let results, let timestamp):
            try container.encode("updateRisultati", forKey: .type)
            try container.encode(results, forKey: .payload)
            try container.encode(timestamp, forKey: .timestamp)

        case .timetable(let timetable, let timestamp):
            try container.encode("updateProgrammaOrario", forKey: .type)
            try container.encode(timetable, forKey: .payload)
            try container.encode(timestamp, forKey: .timestamp)

        case .unsupported:
            let context = EncodingError.Context(codingPath: [], debugDescription: "Invalid payload.")
            throw EncodingError.invalidValue(self, context)
        }
    }

    // MARK: - Accessor

    var timestamp: Date {
        switch self {
        case .competitors(_, let timestamp): return timestamp
        case .note(_, let timestamp): return timestamp
        case .session(_, let timestamp): return timestamp
        case .event(_, let timestamp): return timestamp
        case .rider(_, let timestamp): return timestamp
        case .results(_, let timestamp): return timestamp
        case .timetable(_, let timestamp): return timestamp
        case .unsupported(_): return .distantPast
        }
    }

}
