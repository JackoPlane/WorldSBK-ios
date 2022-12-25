//
//  Competitors.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import Foundation

struct TimeEntry {

    let number: Int
    let section: Int
    let time: Int?
    let boxState: RiderBoxState
    let colour: Int?

    // MARK: - Init

    init(number: Int, section: Int, time: Int?, boxState: RiderBoxState, colour: Int?) {
        self.number = number
        self.section = section
        self.time = time
        self.boxState = boxState
        self.colour = colour
    }

}

struct Competitors {

    typealias RiderNumber = Int
    typealias Section = Int

    typealias Time = Int
    typealias Times = [Time]

    var sectionTimes: [TimeEntry] = []
    var defaultTimes: [Section: Time] = [:]
    var f: [RiderNumber: Times] = [:]
    var isTrialSession: Bool = false
    var numberOfTraits: Int = 0

    /// AggiungiTempiMigliori
    mutating func addBetterTimes(_ update: RiderUpdate) {
        addBetterTimes(for: update.riderNumber, times: update.times ?? [])
    }

    mutating func addBetterTimes(for rider: RiderNumber, times: Times) {
        f[rider] = times
    }

    /// AggiungiTempoTratto
    mutating func addSectionTime(_ rider: RiderUpdate) {
        addSectionTime(for: rider.riderNumber, section: rider.currentSection, time: rider.timePassed ?? 0, boxState: rider.boxState, colour: rider.colour)
    }

    mutating func addSectionTime(for rider: RiderNumber, section: Section, time: Time, boxState: RiderBoxState, colour: Int?) {
        let value = TimeEntry(number: rider, section: section, time: time, boxState: boxState, colour: colour)
        sectionTimes.append(value)
    }

    // AggiungiTempoDefaultTratto
    mutating func addDefaultTime(for section: Section, time: Time) {
        defaultTimes[section] = time
    }

    /// ColoreConcorrente
    func competitorColor(n: Int) -> String {
        return hasLeftPits(rider: n) ? "#FFF" : g(n)
    }

    /// DurataAnimazione
    func animationDuration(n: Int, i: Int) -> Int {
        var r = (isTrialSession) ? o(n, i) + d(n, i) : k(n, i, 5)

        // I think this is right?
        // r > t(i) + 6e4 && (r = t(i))
        if r > defaultTime(for: i) + 6000 {
            r = defaultTime(for: i)
        }

        return r
    }

    /// SessioneDiProve
    mutating func trialSession(_ n: Bool) {
        isTrialSession = n
    }

    /// NumeroTratti
    mutating func numberOfTraits(_ n: Int) {
        numberOfTraits = n
    }

    /// UscitoDaiBox (Also known as `h(_:)`)
    func hasLeftPits(rider: RiderNumber) -> Bool {
        if case .leftPits = (sectionTimes.last(where: { $0.number == rider })?.boxState ?? .inPits) {
            return true
        }

        return false
    }

    /// TempoDefaultTratto (Also known as `t(_:)`)
    func defaultTime(for section: Section) -> Int {
        return numberOfTraits == 0 ? 60000 : defaultTimes[section - 1]!
    }


    // MARK: - Private helpers

    private func g(_ t: Int) -> String {
        var i: String = "#000"
        let r = sectionTimes.last(where: { $0.number == t })

        if sectionTimes.count > 0, let r = r {
            switch r.colour {
                case 0: i = "#000"
                case 1: i = "#F00"
                case 2: i = "#F00"
                case 3: i = "#D2830E"
                case 4: i = "#00F"
                case 5: i = "#00F"
                default: i = "#F0F"
            }
        }

        return i
    }

    private func k(_ i: Int, _ u: Int, _ f: Int) -> Int {
        let o = sectionTimes.filter { $0.time != nil }
        let e = o.filter { $0.number == i && $0.section == u }.suffix(f)

        if e.count > 0 {
            let reduced = e.reduce(0) { (total, element) in total + (element.time ?? 0) }
            return Int(reduced / e.count)
        } else {
            return defaultTime(for: u)
        }
    }

    private func d(_ t: Int, _ i: Int) -> Int {
        var u = 0
        let e = sectionTimes.filter { $0.time != nil }
        let f = e.filter { $0.number == t && $0.section == s(i) }
        let c = o(t, s(i))
        u = (f.last!.time! - c) / (u > 0 ? 2 : 4)

        return u
    }

    private func o(_ i: Int, _ u: Int) -> Int {
        let h = sectionTimes.filter { $0.number == i && $0.section == u }
        let e = r(h.compactMap { $0.time })
        let s = f[i]?[u - 1]
        let o = e.min() ?? (s == nil ? defaultTime(for: u) : s)

        return o!
    }

    private func s(_ n: Int) -> Int {
        return n == 1 ? numberOfTraits : n - 1
    }

    private func r(_ n: [Int?]) -> [Int] {
        // From what I can tell, this filters out Nulls?
        return n.compactMap { $0 }
    }

}
