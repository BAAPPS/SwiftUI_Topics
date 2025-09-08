//
//  KFImage+SafeURL.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import SwiftUI
import Kingfisher

extension KFImage {
    static func url(from string: String?) -> KFImage {
        guard let string else {
            // Fallback placeholder
            return KFImage(Bundle.main.url(forResource: "placeholder", withExtension: "png"))
        }

        // Fix IGDB protocol-relative URL
        let fixedString: String
        if string.hasPrefix("//") {
            fixedString = "https:" + string
        } else {
            fixedString = string
        }

        if let url = URL(string: fixedString) {
            return KFImage(url)
        }

        // Fallback placeholder if URL fails
        return KFImage(Bundle.main.url(forResource: "placeholder", withExtension: "png"))
    }
}
