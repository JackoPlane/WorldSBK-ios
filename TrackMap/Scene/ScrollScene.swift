//
//  ScrollScene.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import SpriteKit
import Foundation

class ScrollScene: SKScene  {

    enum Errors: Error {
        case invalidOperation
    }

    public let rootNode: SKSpriteNode

    // MARK: - Init

    override init(size: CGSize) {
        self.rootNode = SKSpriteNode()
        self.rootNode.anchorPoint = .zero
        self.rootNode.position = .zero

        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    internal var scale: CGFloat {
        return xScale
    }

    internal var maximumZoomScale: CGFloat {
        1
    }

    internal var minimumZoomScale: CGFloat {
        1
    }

    internal var initialZoomScale: CGFloat {
        1
    }

    // MARK: - Functions

    public func stopScene() {
        removeAllActions()
    }


}
