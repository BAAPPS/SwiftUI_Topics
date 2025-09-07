//
//  View+Extensions.swift
//  HarvardArtModel
//
//  Created by D F on 9/7/25.
//

import SwiftUI

// MARK: - View Modifiers

struct OverlayEffectModifier: ViewModifier {
    var opacity: Double = 0.5
    var color: Color = .black
    
    func body(content: Content) -> some View {
        content
            .overlay(
                color
                    .opacity(opacity)
                    .ignoresSafeArea()
                
            )
    }
}

struct BackButtonModifier: ViewModifier {
    var title: String
    var imageName: String = "chevron.left"
    var color: Color = .white
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content:Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
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

struct NavigationBarModifier: ViewModifier {
    var backgroundColor:UIColor
    var titleColor: UIColor
    init(backgroundColor: UIColor, titleColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        appearance.titleTextAttributes = [.foregroundColor:titleColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = titleColor
    }
    
    func body(content: Content) -> some View {
        content
    }
}


struct DividerModifier: ViewModifier {
    var height: CGFloat = 25
    var color: Color = .black.opacity(0.7)
    
    func body(content:Content) -> some View {
        Divider()
            .frame(height: height)
            .background(color)
    }
}

extension View {
    func overlayEffect(opacity: Double = 0.5, color: Color = .black) -> some View {
        self.modifier(OverlayEffectModifier(opacity: opacity, color: color))
    }
    
    func backButton(title:String = "", imageName: String = "chevron.left", color: Color = .white.opacity(0.9)) -> some View {
        self.modifier(BackButtonModifier(title: title, imageName: imageName, color: color))
    }
    
    func navigationBarColor(background: Color, titleColor: Color) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: UIColor(background), titleColor: UIColor(titleColor)))
    }
    
    func shortDivider(height: CGFloat = 25, color: Color = .black.opacity(0.7)) -> some View {
        self.modifier(DividerModifier(height: height, color: color))
    }
}



// MARK: - View

struct IconTextRow: View {
    let systemName: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: systemName)
                .foregroundColor(.cobaltBlue)
                .font(.title2)
                .frame(width: 20, alignment: .center) // forces icon top alignment
            Text(text)
                .foregroundColor(.cornflowerBlue)
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true) // avoids extra line height pushing icon down
        }
        .accessibilityElement(children: .combine) // Combines icon + text for screen readers
        .accessibilityLabel("\(text)")            // Reads only the text (icon is decorative)
        .accessibilityAddTraits(.isStaticText)
    }
}

