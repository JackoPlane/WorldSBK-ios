//
//  RaceReplayer.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import Foundation

public class RaceReplayer {

    private let updates: [HubEvent]

    private var hub: LiveTimingHub?

    private var timer: Timer?

    public private(set) var isReplaying: Bool = false

    // MARK: - Init

    public init?(fileName: String) {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }

        do {
            let jsonData = try Data(contentsOf: filePath)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601

            let allUpdates = try jsonDecoder.decode([HubEvent].self, from: jsonData)
            self.updates = allUpdates.filter {
                if case .unsupported = $0 {
                    return false
                } else {
                    return true
                }
            }
        } catch {
            print("Error occurred: \(error)")
            return nil
        }
    }


    // MARK: - Replaying

    func start(withHub hub: LiveTimingHub? = nil) {
        self.hub = hub
        isReplaying = true
        emitEvent(atIndex: updates.startIndex)
    }

    func stop() {
        isReplaying = false
        self.timer?.invalidate()
        self.timer = nil
    }

    // MARK: - Event Emitting

    private func emitEvent(atIndex index: Array<HubEvent>.Index) {
        // Reset the timer
        // Invalidate and cleanup existing timer object
        self.timer?.invalidate()
        self.timer = nil

        // Double check the event index is valid
        guard updates.indices.contains(index) else { return }

        let event = updates[index]

        // Emit event
        hub?.didGetUpdate(event)

        // Check if theres more events
        let nextIndex = index.advanced(by: 1)
        if nextIndex != updates.endIndex {
            let nextEvent = updates[nextIndex]
            var timeDiff = event.timestamp.distance(to: nextEvent.timestamp)

            // Speed though the first 200 events
            if nextIndex < 200 {
                timeDiff /= 10
            }

            // Finally, create a timer. This specifically needs to be created on the main thread
            DispatchQueue.main.async { [weak self] in
                self?.timer = Timer.scheduledTimer(withTimeInterval: timeDiff, repeats: false, block: { [weak self] _ in
                    self?.emitEvent(atIndex: nextIndex)
                })
            }
        }
    }

}
