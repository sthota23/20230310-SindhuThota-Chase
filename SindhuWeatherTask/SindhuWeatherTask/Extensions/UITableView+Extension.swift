//
//  UITableView+Extension.swift
//  SindhuWeatherTask
//
//  Created by Sindhu Thota on 09/03/23.
//

import UIKit

extension UITableView {
    
    func setFallbackView(withTitle: String, withText: String) {
        let illustrationsFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        let illustrationView = FallbackIllustrationsView.init(frame: illustrationsFrame)
        illustrationView.setFallbackTitle = withTitle
        illustrationView.setFallbackText = withText
        self.backgroundView = illustrationView
    }
    func restore() {
        self.backgroundView = nil
    }
}
