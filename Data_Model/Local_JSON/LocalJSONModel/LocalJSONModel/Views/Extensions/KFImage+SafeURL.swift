//
//  KFImage+SafeURL.swift
//  LocalJSONModel
//
//  Created by D F on 9/2/25.
//


import Kingfisher
import SwiftUI

extension KFImage {
    static func url(from string: String?) -> KFImage {
        if let string, let url = URL(string: string) {
            return KFImage(url)
        }
        // fallback: empty URL → use a placeholder asset
        return KFImage(Bundle.main.url(forResource: "placeholder", withExtension: "png")!)

    }
}
