//
//  NavigationBarButton.swift
//  MVVMStudy
//
//  Created by Mert Tuncbilek on 26.02.2020.
//  Copyright © 2020 Evrensel Software Solutions. All rights reserved.
//

import Foundation
import UIKit

/*typealias NavigationBarButtonHandler = () -> Void

enum NavigationBarButton: Equatable {
    case back(NavigationBarButtonHandler?)
    case settings
    case fasty(NavigationBarButtonHandler?)
    case close(NavigationBarButtonHandler?)
    case custom(NavigationBarButtonData)

    var title: String? {
        switch self {
        case .custom(let buttonData):
            return buttonData.title?.value
        default:
            return nil
        }
    }

    var icon: UIImage? {
        switch self {
        case .back:
            return #imageLiteral(resourceName: "arrowBack.pdf").with(size: 14)
        case .fasty:
            return nil
        case .settings:
            return #imageLiteral(resourceName: "ayar")
        case .close:
            return #imageLiteral(resourceName: "close").with(size: 14)
        case .custom(let buttonData):
            return buttonData.image
        }
    }

    var accessibilityKey: AccessibilityKey {
        switch self {
        case .back:
            return .back
        case .fasty:
            return .fasty
        case .settings:
            return .settings
        case .close:
            return .close
        case .custom:
            return .custom
        }
    }

    static func == (lhs: NavigationBarButton, rhs: NavigationBarButton) -> Bool {
        switch (lhs, rhs) {
        case (.back, .back):
            return true
        case (.fasty, .fasty):
            return true
        case (.settings, .settings):
            return true
        case (.close, .close):
            return true
        case (.custom, .custom):
            return true
        default:
            return false
        }
    }

}

enum NavigationBarButtonPosition: Int {
    case left = 1
    case right
}

class NavigationBarButtonData {
    var title: ResourceKey?
    var image: UIImage?
    var handler: ((UIButton) -> Void)?

    init(title: ResourceKey? = nil, image: UIImage?, handler: ((UIButton) -> Void)?) {
        self.title = title
        self.image = image
        self.handler = handler
    }
}*/
