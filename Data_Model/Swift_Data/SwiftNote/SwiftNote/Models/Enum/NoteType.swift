//
//  NoteTypeModel.swift
//  SwiftNote
//
//  Created by D F on 9/23/25.
//

import Foundation

enum NoteType: String, CaseIterable, Identifiable, Codable {
    case personal = "Personal"
    case work = "Work"
    case study = "Study"
    case subject = "Subject"
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .personal: "👤 Personal"
        case .work: "💼 Work"
        case .study: "📚 Study"
        case .subject: "📝 Subject"
        }
    }
}
