//
//  EventUpdate.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import Foundation

struct EventUpdate: ReplayEventUpdate, Decodable {

    var type: EventUpdateType = .event

//    n != null && (n.md != "" && (t = "(" + n.md + ")"), n.gd != "" && (i = n.gd.toUpperCase()), n.sd != "" && (r = "(" + n.sd + ")"), n.pr ? n.ri != null && n.ri.cd.nu != null && ($("#riferimentoNumero").text(n.ri.cd.nu), $("#riferimentoCognome").html(n.ri.cd.co.toUpperCase()), $("#riferimentoNominativo").html(nominativoConduttore(n.ri.cd)), $("#riferimentoMezzo").text(n.ri.cd.me), $("#riferimentoTempo").text(n.ri.tp), $("#riferimentoIntermedio1").text(n.ri.in[0]), $("#riferimentoIntermedio2").text(n.ri.in[1]), $("#riferimentoIntermedio3").text(n.ri.in[2]), $("#riferimenti").show()) : $("#riferimenti").hide(), $("#labelNominativo").text(n.mo ? "RIDER" : "DRIVER"), $("#labelMezzo").text(n.mo ? "BIKE" : "CAR"));
//    $("#manifestazione").text(t);
//    $("#gara").text(i);
//    $("#sessione").text(r)
//}

}
