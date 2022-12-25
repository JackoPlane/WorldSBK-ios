//
//  ViewModel.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import SpriteKit
import Foundation

final public class ViewModel {

    public struct Constants {
        static let DEBUG_SCENE_VIEW: Bool = true
        static let DRAW_TRACK_SECTIONS: Bool = false
    }

    public enum Tracks {
        case philipIsland
    }

    // MARK: - Track Loading

    public func loadTrack(_ track: Tracks) -> SKScene? {
        var loadedTrack: Track?

        switch track {
        case .philipIsland:
            loadedTrack = PhilipIslandTrack()
        }

        if let loadedTrack {
            return TrackScene(track: loadedTrack)
        }

        return nil
    }


}
