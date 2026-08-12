//
//  View+Haptic.swift
//  Wordsy
//
//  Created by aex on 12.08.2026.
//

import SwiftUI

extension View {
    func hapticTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) -> some View {
        self.simultaneousGesture(TapGesture().onEnded {
            UIImpactFeedbackGenerator(style: style).impactOccurred()
        })
    }
}
