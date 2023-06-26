//
//  Haptic.swift
//  GP-OnboardingSign
//
//  Created by Razan Mohammed Alzannan on 27/11/1444 AH.
//

import Foundation
import SwiftUI
class HapticManager: ObservableObject {
    static let instance = HapticManager () 
    func notification (type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact (style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator (style: style)
        generator.impactOccurred()
    }
}
