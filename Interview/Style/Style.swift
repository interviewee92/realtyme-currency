//
//  Style.swift
//  Interview
//
//  Created by interviewee92 on 08/07/2024.
//

import UIKit

final class Style {
    static var shared = Style()

    func getNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        return appearance
    }
}

extension UINavigationController {
    convenience init(style: Style) {
        self.init()

        let appearance = style.getNavigationBarAppearance()
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
