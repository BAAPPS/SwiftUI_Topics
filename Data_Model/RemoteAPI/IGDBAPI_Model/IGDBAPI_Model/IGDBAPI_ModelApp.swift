//
//  IGDBAPI_ModelApp.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/7/25.
//

import SwiftUI

@main
struct IGDBAPI_ModelApp: App {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.gray800)   // nav bar background
        appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.gray100)] // regular title
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.gray100)] // large title
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
