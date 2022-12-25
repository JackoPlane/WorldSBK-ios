//
//  UserDefaults+Settings.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import Foundation

extension UserDefaults {

    @objc var showDebugOverlay: Bool {
        get {
            return bool(forKey: "show_debug_overlay")
        }
        set {
            set(newValue, forKey: "show_debug_overlay")
        }
    }

    @objc var drawTrackSections: Bool {
        get {
            return bool(forKey: "draw_track_sections")
        }
        set {
            set(newValue, forKey: "draw_track_sections")
        }
    }

    @objc var useTextures: Bool {
        get {
            return bool(forKey: "use_textures")
        }
        set {
            set(newValue, forKey: "use_textures")
        }
    }

    @objc var debugMasterTrackNode: Bool {
        get {
            return bool(forKey: "debug_master_track_node")
        }
        set {
            set(newValue, forKey: "debug_master_track_node")
        }
    }

    @objc var singleRiderMode: Bool {
        get {
            return bool(forKey: "single_rider_mode")
        }
        set {
            set(newValue, forKey: "single_rider_mode")
        }
    }

}
