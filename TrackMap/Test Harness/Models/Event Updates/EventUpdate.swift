//
//  EventUpdate.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import Foundation

struct EventUpdate: ReplayEventUpdate, Codable {

    var type: EventUpdateType = .event

    struct Weather: Codable {
        let conditions: String

        enum CodingKeys: String, CodingKey {
            case conditions = "cn"
        }
    }

    let name: String
    let race: String
    let isMotorcycleEvent: Bool

    let circuitName: String
    let session: String

    let weather: Weather

    let numberOfCircuitSections: Int
    let isTrialSession: Bool

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case name = "md"
        case race = "gd"
        case isMotorcycleEvent = "mo"

        case circuitName = "au"
        case session = "sd"

        case weather = "mt"

        case numberOfCircuitSections = "nt"
        case isTrialSession = "pr"
    }

}


//{
//    "timestamp": "2020-03-01T03:58:02Z",
//    "args": [{
//        "ta": true,
//        "mt": {
//            "tp": 0,
//            "ta": 0,
//            "um": 0,
//            "cn": "Dry"
//        },
//        "fu": 11,
//        "pr": false,
//        "ri": null,
//        "gd": "WorldSBK",
//        "ni": 3,
//        "md": "Yamaha Finance Australian Round, 28 February - 1 March 2020",
//        "ga": 1,
//        "sd": "Race 2",
//        "au": "PHILL",
//        "rm": true,
//        "ma": 1,
//        "nt": 7,
//        "se": "003",
//        "mo": true
//    }],
//    "event": "updateEvento"
//}
