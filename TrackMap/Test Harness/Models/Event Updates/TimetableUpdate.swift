//
//  TimetableUpdate.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import Foundation

struct TimetableUpdate: ReplayEventUpdate, Codable {

    var type: EventUpdateType = .timetable

//    [{
//        "se": "003",
//        "ga": 1,
//        "gd": "World Superbike",
//        "du": "22 Laps",
//        "or": "2020-03-01T04:00:00Z",
//        "sd": "Race 2",
//        "ic": false
//    }]
}
