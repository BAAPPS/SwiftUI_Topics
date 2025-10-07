//
//  ContentView.swift
//  SwiftSettingsManager
//
//  Created by D F on 10/7/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State private var settingsVM: SettingsViewModel
    
    init(context: ModelContext){
        _settingsVM = State(wrappedValue: SettingsViewModel(context: context))
    }
    var body: some View {
        NavigationStack {
            AppSettingsView()
        }
    }
}

#Preview {
   
    let container = try! ModelContainer(for: AppSettings.self)
    let context = ModelContext(container)
    
    ContentView(context: context)
        .environment(\.modelContext, context)
}
