//
//  PaddedLabel.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import UIKit
import Foundation

class PaddedLabel: UILabel {

    private let edgeInsets: UIEdgeInsets

    required init(withInsets top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.edgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += edgeInsets.top + edgeInsets.bottom
            contentSize.width += edgeInsets.left + edgeInsets.right
            return contentSize
        }
    }

}
