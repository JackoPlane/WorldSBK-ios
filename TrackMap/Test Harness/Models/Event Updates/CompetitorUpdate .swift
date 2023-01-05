//
//  CompetitorUpdate .swift
//  TrackMap
//
//  Created by Jack Perry on 25/12/2022.
//

import Foundation

struct CompetitorUpdate: ReplayEventUpdate, Codable, Hashable {

    var type: EventUpdateType = .riders


    let position: Int
    let riderNumber: Int

    let firstName: String
    let surname: String

    let brand: String
    let team: String
    let motorcycle: String

    let nationality: String

    // MARK: - Errors


    enum CompetitorUpdateError: Error {
        case decodingError
    }

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case position = "gu"
        case riderNumber = "nu"

        case firstName = "no"
        case surname = "co" // Cognome

        case brand = "me"
        case team = "te"
        case motorcycle = "mo" // Motociclo

        case nationality = "na" // n=Nazionalità
    }


    // MARK: - Decoding

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let rider = Int(try container.decode(String.self, forKey: .riderNumber)) {
            self.riderNumber = rider
        } else {
            throw CompetitorUpdateError.decodingError
        }

        self.position = try container.decode(Int.self, forKey: .position)

        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.surname = try container.decode(String.self, forKey: .surname)

        self.brand = try container.decode(String.self, forKey: .brand)
        self.team = try container.decode(String.self, forKey: .team)
        self.motorcycle = try container.decode(String.self, forKey: .motorcycle)

        self.nationality = try container.decode(String.self, forKey: .nationality)
    }

    // MARK: - Encoding





//    function l(n) {
//        var f = s[t.CORPO].struttura,
//            i;
//        if (h = n, f != null && h != null) {
//            var e = tt(n, v, "nu", "nu", "gu", "gu"),
//                c = f.render(e),
//                l = $(o).html(),
//                r = $("<table>").append(c).find("tr"),
//                u = $("<table>").append(l).find("tr");
//            if (r.length == 0)
//                $(o + " tr").remove();
//            else if (u.length > r.length)
//                $(o + " tr:gt(" + (r.length - 1) + ")").remove();
//            else
//                for (i = 0; i < r.length; i++)
//                    i + 1 > u.length ? $(o).append(r[i]) : $(r[i]).html() != $(u[i]).html() && ($(o + " tr:nth-child(" + (i + 1) + ")").remove(), i == 0 ? $(o).prepend(r[i]) : $(r[i]).insertAfter($(o + " tr:nth-child(" + i + ")")))
//        }
//    }

}

//{
//                "nu": "1",
//                "me": "Kawasaki",
//                "gu": 1,
//                "na": "GBR",
//                "co": "REA",
//                "no": "Jonathan",
//                "mo": "ZX-10RR",
//                "te": "Kawasaki Racing Team WorldSBK"
//            }
