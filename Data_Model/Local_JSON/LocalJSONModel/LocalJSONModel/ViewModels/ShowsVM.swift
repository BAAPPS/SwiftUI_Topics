//
//  File.swift
//  LocalJSONModel
//
//  Created by D F on 9/2/25.
//

import Foundation


@Observable
class ShowsVM {
    let shows: [ShowsModel] = Bundle.main.decode("tvb_shows.json")
}
