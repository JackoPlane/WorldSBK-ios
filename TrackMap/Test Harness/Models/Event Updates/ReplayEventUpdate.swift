//
//  EventUpdate.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import Foundation

public enum EventUpdateType: String, Codable {
    case rider = "updatePassaggio"
    case session = "updateDurataSessione"
    case results = "updateRisultati"
    case note = "updateNota"
    case event = "updateEvento"
    case timetable = "updateProgrammaOrario"
    case riders = "updateConduttori"
}

public protocol ReplayEventUpdate {

    var type: EventUpdateType { get }

}
