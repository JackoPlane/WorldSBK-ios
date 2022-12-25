//
//  RaceReplayer.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import Foundation

public class RaceReplayer {

    private let updates: [ReplayUpdate]

    private var timer: Timer?

    public private(set) var isReplaying: Bool = false
    public var emitter: ((ReplayUpdate) -> Void)? = nil

    // MARK: - Init

    public init?(fileName: String, emitter: ((ReplayUpdate) -> Void)? = nil) {
        self.emitter = emitter

        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }

        do {
            let jsonData = try Data(contentsOf: filePath)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601

            let updates = try jsonDecoder.decode([ReplayUpdate].self, from: jsonData)

            let trimmedUpdates = Array(updates.dropFirst(200)) as? [ReplayUpdate]
            self.updates = trimmedUpdates?.compactMap { $0 } ?? []
        } catch {
            print("Error occurred: \(error)")
            return nil
        }
    }


    // MARK: - Replaying

    func start() {
        isReplaying = true
        emitEvent(atIndex: updates.startIndex)
    }

    func stop() {
        isReplaying = false
        self.timer?.invalidate()
        self.timer = nil
    }

    // MARK: - Event Emiting

    private func emitEvent(atIndex index: Array<ReplayUpdate>.Index) {
        // Reset the timer
        // Invalidate and cleanup existing timer object
        self.timer?.invalidate()
        self.timer = nil

        // Double check the event index is valid
        guard updates.indices.contains(index) else { return }

        let event = updates[index]

        // Emit event
        emitter?(event)

        // Check if theres more events
        let nextIndex = index.advanced(by: 1)
        if nextIndex != updates.endIndex {
            let nextEvent = updates[nextIndex]
            let timeDiff = event.timestamp.distance(to: nextEvent.timestamp)

            // Finally, create a timer. This specifically needs to be created on the main thread
            DispatchQueue.main.async { [weak self] in
                self?.timer = Timer.scheduledTimer(withTimeInterval: timeDiff, repeats: false, block: { [weak self] _ in
                    self?.emitEvent(atIndex: nextIndex)
                })
            }
        }
    }

}
