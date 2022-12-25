//
//  UIStackView+Builder.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import UIKit
import Foundation

extension UIStackView {

    convenience init(axis: NSLayoutConstraint.Axis, distribution: Distribution = .fill, alignment: Alignment = .fill, spacing: CGFloat = 0) {
        self.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }

}
