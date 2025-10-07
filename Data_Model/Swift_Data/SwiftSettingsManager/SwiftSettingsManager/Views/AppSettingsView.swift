//
//  AppSettingsView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI

struct AppSettingsView: View {
    var body: some View {
        VStack{
            Text("All Settings Go Here")
        }
        .navigationTitle("Your Settings")
    }
}

#Preview {
    NavigationStack {
        AppSettingsView()
    }
}
