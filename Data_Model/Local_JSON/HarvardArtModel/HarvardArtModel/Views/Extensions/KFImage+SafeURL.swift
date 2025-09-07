//
//  KFImage+SafeURL.swift
//  HarvardArtModel
//
//  Created by D F on 9/7/25.
//

import SwiftUI
import Kingfisher

extension KFImage {
    static func url(from string:String?) -> KFImage {
        if let string, let url = URL(string: string) {
            return KFImage(url)
        }
        // fallback: empty URL → use a placeholder asset
        return KFImage(Bundle.main.url(forResource: "placeholder", withExtension: "png")!)

    }
}
