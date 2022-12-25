//
//  SessionUpdate.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import Foundation

struct SessionUpdate: ReplayEventUpdate, Decodable {

    enum Status: Int, Codable, CustomStringConvertible {
        case redFlag = 0
        case greenFlag = 1
        case finishing = 2
        case completed = 3

        var description: String {
            switch self {
            case .redFlag: return "Red flag"
            case .greenFlag: return "Green flag"
            case .finishing: return "Finishing" // Flag URL: /Content/Images/BandieraSessione.gif
            case .completed: return "Completed"
            }
        }

        var flag: String {
            switch self {
            case .redFlag: return "🔴"
            case .greenFlag: return "🟢"
            case .finishing: return "🏁"
            case .completed: return "✔️"
            }
        }
    }

    var type: EventUpdateType = .session

    let status: Status
    let runTime: Int
    let totalTime: Int

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case status = "st"
        case runTime = "du"
        case totalTime = "dt"
    }

    // MARK: - Computed

    var displayTime: String {
        var runTime = Double(runTime)
        if status == .greenFlag {
            runTime -= 1
        }

        return "\(formatTime(runTime)) / \(formatTime(Double(totalTime)))"
    }

    private func formatTime(_ time: Double) -> String {
        let r = (time / 3600).truncatingRemainder(dividingBy: 24)
        let i = (time / 60).truncatingRemainder(dividingBy: 60)
        let f = (time).truncatingRemainder(dividingBy: 60)

        let o = ((r == 0 ? "" : (r < 10) ? "0\(Int(r)):" : "\(Int(r)):"))
        let s = ((r == 0 && i == 0) ? "" : ((r == 0) ? "\(Int(i))" : ((i < 10) ? "0\(Int(i))" : "\(Int(i))"))) + "'"
        let h = ((r == 0 && i == 0) ? "\(Int(f))" : (f < 10) ? "0\(Int(f))" : "\(Int(f))")

        return "\(o)\(s)\(h)"
    }

}


// MARK: - Notes

//Javascript event handler
//
//livetiming.client.updateDurataSessione = function (value) {
//   if (value != null)
//       livetiming2.AggiornaDurataSessione(value);
//}
