//
//  View+Extensions.swift
//  IGDBAPI_Model
//
//  Created by D F on 9/8/25.
//

import SwiftUI

// MARK: - View Modifiers

struct OverlayEffectModifier: ViewModifier {
    var opacity:Double = 0.6
    var color: Color = .gray500
    
    func body(content: Content) -> some View {
        content
            .overlay(
                color
                    .opacity(opacity)
                    .ignoresSafeArea()
            )
    }
}


struct BackButtonModifer: ViewModifier {
    var title: String
    var imageName: String = "chevron.left"
    var color:Color = .gray100
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        HStack{
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
    var color: Color = .gray300
    
    func body(content:Content) -> some View {
        Divider()
            .frame(height: height)
            .background(color)
    }
}


extension View {
    func overlayEffect(opacity: Double = 0.5, color: Color = .gray800) -> some View {
        self.modifier(OverlayEffectModifier(opacity: opacity, color: color))
    }
    
    func backButton(title:String = "", imageName: String  = "chevron.left", color: Color = .gray100) -> some View {
        self.modifier(BackButtonModifer(title: title, imageName: imageName, color: color))
    }
    
    func dividerModifier(height: CGFloat = 25, color: Color = .gray200) -> some View{
        self.modifier(DividerModifier(height: height, color: color))
    }
}


// MARK: - View

struct IconTextRow: View {
    let systemName: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 13) {
            Image(systemName: systemName)
                .foregroundColor(.gray300)
                .font(.title2)
                .frame(width: 20, alignment: .center)
            Text(text)
                .foregroundColor(.gray100)
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine) // Combines icon + text for screen readers
        .accessibilityLabel("\(text)")            // Reads only the text (icon is decorative)
        .accessibilityAddTraits(.isStaticText)
    }
}
