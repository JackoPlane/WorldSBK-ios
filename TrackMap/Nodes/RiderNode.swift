//
//  RiderNode.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import SpriteKit
import Foundation

class RiderNode: SKNode {

    public var section: Int
    private let label = SKLabelNode(text: "45")
    private let circle = SKShapeNode(circleOfRadius: 18)

    init(rider: Int, section: Int = 0, color: UIColor? = nil) {
        self.section = section
        super.init()

        let colors: [UIColor] = [.systemBlue, .systemGreen, .systemIndigo, .systemOrange, .systemPink, .systemPurple, .systemRed, .systemTeal, .systemYellow]

        let fillColor = colors.randomElement() ?? .magenta
        circle.fillColor = fillColor
        circle.strokeColor = fillColor.darker()
        circle.alpha = 0.6

        label.text = "\(rider)"
        label.fontSize = 20
        label.fontName = "AvenirNext-Bold"
        label.position = CGPoint(x: circle.frame.midX, y: circle.frame.midY - 8)

        addChild(circle)
        addChild(label)

        zPosition = 9999
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
