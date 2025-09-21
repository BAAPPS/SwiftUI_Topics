//
//  View+Extensions.swift
//  Coverr_Model
//
//  Created by D F on 9/16/25.
//

import Foundation
import SwiftUI

// MARK: - Shape

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


// MARK: - Date formatting for views
extension Date {
    var displayString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium   // Sep 16, 2025
        formatter.timeStyle = .none     // no time shown
        // formatter.timeStyle = .short    // 7:30 PM
        return formatter.string(from: self)
    }
}


// MARK: - ViewModifier

struct DividerModifer: ViewModifier {
    var height: CGFloat = 25
    var color: Color = .black
    func body(content: Content) -> some View {
        Divider()
            .frame(height: height)
            .background(color)
    }
}


struct NetworkBannerModifier: ViewModifier {
    var networkMonitor: NetworkMonitorProtocol

    func body(content: Content) -> some View {
        ZStack(alignment:.top) {
            content
            
            if !networkMonitor.isConnected {
                HStack {
                    Image(systemName: "wifi.slash")
                        .foregroundColor(.white)
                    Text("No Internet Connection")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .transition(.move(edge: .top).combined(with: .opacity))
                .animation(.easeInOut, value: networkMonitor.isConnected)
            }
        }
    }
}


extension View {
    
    func dividerModifier(height: CGFloat = 25, color: Color = .black) -> some View {
        self.modifier(DividerModifer(height: height, color: color))
    }
    
    func networkBanner(using networkMonitor: NetworkMonitorProtocol) -> some View {
           modifier(NetworkBannerModifier(networkMonitor: networkMonitor))
       }
    
    func cornerRadiusModifier(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius:radius, corners: corners))
    }
}

// MARK: - View
struct IconTextRow: View {
    let systemName: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(.black.opacity(0.5))
                .font(.title2)
                .frame(width: 20, alignment: .center)
            Text(text)
                . font(.callout)
                .foregroundColor(.black.opacity(0.7))
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(text)")
        .accessibilityAddTraits(.isStaticText)
    }
}
