//
//  LiveTimingHub.swift
//  TrackMap
//
//  Created by Jack Perry on 28/12/2022.
//

import Combine
import Foundation

struct CodableUpdate: Codable {

}

final class LiveTimingHub: ObservableObject {

    public var eventUpdates = PassthroughSubject<HubEvent, Never>()

    func didGetUpdate(_ update: HubEvent) {
        eventUpdates.send(update)
    }

}
