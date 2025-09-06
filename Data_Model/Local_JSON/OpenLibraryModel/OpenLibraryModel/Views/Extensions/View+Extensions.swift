//
//  View+Extensions.swift
//  OpenLibraryModel
//
//  Created by D F on 9/3/25.
//

import SwiftUI

// MARK: - View Modifiers

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor
    var titleColor: UIColor
    
    init(backgroundColor: UIColor, titleColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: titleColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = titleColor
    }
    
    func body(content:Content) -> some View {
        content
    }
}

struct BackButtonModifier: ViewModifier {
    var title: String
    var imageName: String = "chevron.left"
    var color: Color = .white
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        
        content
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: imageName)
                                .foregroundColor(color)
                            Text(title)
                        }
                    }
                }
            }
    }
    
}


struct DividerModifier: ViewModifier {
    var height: CGFloat = 25
    var color: Color = .black.opacity(0.6)
    
    func body(content: Content) -> some View {
        Divider()
            .frame(height: height)
            .background(color)
    }
}



extension View {
    
    func navigationBarColor(background: Color, titleColor: Color) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: UIColor(background), titleColor: UIColor(titleColor)))
    }
    
    
    func backButton(title: String = "", imageName: String = "chevron.left", color: Color = .white.opacity(0.9)) -> some View {
        self.modifier(BackButtonModifier(title: title, imageName: imageName, color: color))
    }
    
    
    func shortDivider(height: CGFloat = 25, color: Color = .black.opacity(0.6)) -> some View {
        self.modifier(DividerModifier(height: height, color: color))
    }
}

// MARK: - View

struct IconTextRow: View {
    let systemName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(.rosewoodRed)
                .font(.title2)
            Text(text)
                .foregroundColor(.graniteGray)
                .bold()
        }
    }
}

