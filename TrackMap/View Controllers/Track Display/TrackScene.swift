//
//  TrackScene.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import SpriteKit
import Foundation

final class TrackScene: ScrollScene {

    private lazy var trackCamera: SKCameraNode = {
        let camera = SKCameraNode()
        camera.setScale(1.2)
        camera.position = CGPoint(x: size.width / 2, y: size.height / 2)
        return camera
    }()

    private let track: Track
    private let sectionColors: [UIColor]

    private var trackNodes: [SKNode] = []
    private var sandNodes: [SKNode] = []

    private var masterTrackNode: SKShapeNode?

    private var riders: [Int: RiderNode] = [:]

    public var drawingTrackSections: Bool {
        trackNodes.count > 1
    }

    public private(set) var usingTextures: Bool

    private var previousCameraScale = CGFloat()

    private struct Colours {
        static let sand = UIColor(named: "track-color-sand")!
        static let sandStroke = UIColor(named: "track-color-sand-stroke")!
        static let track = UIColor(named: "track-color-track")!
        static let trackStroke = UIColor(named: "track-color-track-stroke")!
        static let grass = UIColor(named: "track-color-grass")!
        static let pitlane = UIColor(named: "track-color-pitlane")!
        static let runoff = UIColor(named: "track-color-runoff")!
    }

    private struct Textures {
        static let track = UIImage(named: "track-texture-track")!
        static let sand = UIImage(named: "track-texture-sand")!
    }

    // MARK: - Init

    init(track: Track, sectionColors: [UIColor]? = nil) {
        self.track = track
        self.sectionColors = sectionColors ?? [.systemBlue, .systemGreen, .systemIndigo, .systemOrange, .systemPink, .systemPurple, .systemRed, .systemTeal, .systemYellow]
        self.usingTextures = UserDefaults.standard.useTextures
        super.init(size: track.size)
        self.rootNode.size = track.size

        backgroundColor = Self.Colours.grass

        // Build pit lane
        for path in track.pitLane {
            let shapeNode = SKShapeNode(path: path.cgPath)
            shapeNode.strokeColor = Self.Colours.pitlane
            shapeNode.lineWidth = 2
            shapeNode.position = CGPoint(x: 0-13.63, y: 0-16.16) // The "full" track is offset by these x/y values _shrug_
            rootNode.addChild(shapeNode)
        }

        // Sand / Gravel traps
        sandNodes.forEach { $0.removeFromParent() }
        for path in track.sand {
            let shapeNode = SKShapeNode(path: path.cgPath)
            shapeNode.fillColor = Self.Colours.sand
            shapeNode.strokeColor = .clear
            shapeNode.position = CGPoint(x: 0-13.63, y: 0-16.16) // The "full" track is offset by these x/y values _shrug_

            if UserDefaults.standard.useTextures {
                let texture = SKTexture(image: Self.Textures.sand)
                shapeNode.fillTexture = texture
            }

            rootNode.addChild(shapeNode)
            sandNodes.append(shapeNode)
        }

        // Run off areas
        for path in track.runoffAreas {
            let shapeNode = SKShapeNode(path: path.cgPath)
            shapeNode.fillColor = Self.Colours.runoff
            shapeNode.position = CGPoint(x: 0-13.63, y: 0-16.16) // The "full" track is offset by these x/y values _shrug_
            shapeNode.strokeColor = .clear
            rootNode.addChild(shapeNode)
        }

        drawTrackNodes(drawSections: UserDefaults.standard.drawTrackSections)

        addChild(rootNode)
    }
    
    @available(*, unavailable, message: "LotusViewController does not support NSCoding.")
    public required init?(coder: NSCoder) { notImplementedError() }

    // MARK: - Lifecycle

    override func sceneDidLoad() {
        super.sceneDidLoad()

        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: #selector(pinchGestureAction(_:)))
        view?.addGestureRecognizer(pinchGesture)
    }

    override func didMove(to view: SKView) {
        addChild(trackCamera)
        camera = trackCamera
    }

    override func update(_ currentTime: TimeInterval) {
        // This method should be called so that the camera gets updated with the position of the target node.
        // In this case, the player is the target node. So we send the position property as a parameter (CGPoint).
        // self.trackCamera.setCamera(position: self.player.position)
    }

    // MARK: - Track

    public func drawTrackNodes(drawSections: Bool) {
        // Remove any existing nodes
        trackNodes.forEach { $0.removeFromParent() }

        var strokeTexture: SKTexture?
        if UserDefaults.standard.useTextures {
            strokeTexture = SKTexture(image: Self.Textures.track)
        }

        self.masterTrackNode?.removeFromParent()
        self.masterTrackNode = SKShapeNode(path: track.track.cgPath)
        rootNode.addChild(self.masterTrackNode!)
        if UserDefaults.standard.debugMasterTrackNode {
            self.masterTrackNode?.strokeColor = .cyan
            self.masterTrackNode?.lineWidth = 8
        } else {
            self.masterTrackNode?.strokeColor = .clear
            self.masterTrackNode?.lineWidth = 8
        }

        if drawSections {
            trackNodes = []

            for (index, path) in track.trackSections.enumerated() {
                let shapeNode = SKShapeNode(path: path.cgPath)
                shapeNode.strokeColor = sectionColors[index]
                shapeNode.lineWidth = 8
                shapeNode.position = CGPoint(x: 0-13.63, y: 0-16.16) // The "full" track is offset by these x/y values _shrug_
                shapeNode.strokeTexture = strokeTexture
                rootNode.addChild(shapeNode)

                trackNodes.append(shapeNode)
            }
        } else {
            let shapeNode = SKShapeNode(path: track.track.cgPath)
            shapeNode.strokeColor = Self.Colours.track
            shapeNode.lineWidth = 8
            shapeNode.strokeTexture = strokeTexture
            rootNode.addChild(shapeNode)

            trackNodes = [shapeNode]
        }
    }

    public func toggleTextures(enabled: Bool) {
        self.usingTextures = enabled
        if enabled {
            trackNodes.forEach { ($0 as? SKShapeNode)?.strokeTexture = SKTexture(image: Self.Textures.track) }
            sandNodes.forEach { ($0 as? SKShapeNode)?.fillTexture = SKTexture(image: Self.Textures.sand) }
        } else {
            trackNodes.forEach { ($0 as? SKShapeNode)?.strokeTexture = nil }
            sandNodes.forEach { ($0 as? SKShapeNode)?.fillTexture = nil }
        }
    }

    // MARK: - Riders

    func updateRider(_ number: Int, section: Int, duration: Int, timePassed: Int) {

        // Node creation
        var riderNode: RiderNode! = riders[number]
        if riders[number] == nil {
//            riderNode = SKLabelNode(text: "🏍️")
            riderNode = RiderNode(rider: number, section: section)

            riders[number] = riderNode!
            riderNode.position = CGPoint(x: 319, y: 211.2)
            print("Added node for rider #\(number)")
//            riderNode.position = CGPoint(x: 301.2, y: 210.14)
            masterTrackNode?.addChild(riderNode!)

        } else {
            print("Ride #\(number) position: \(riderNode.position)")
        }

        // Animation calc
        var animationDuration: Double = Double(duration)
        var animationOffset: Int = 1
        let lunghezzaCurvaAnimazione = Int(track.track.cgPath.length)

        if timePassed != 0 {
            animationOffset = (lunghezzaCurvaAnimazione * timePassed) / max(duration, 1)
            animationDuration -= Double(timePassed)
        }

        print("Rider #\(number), Section: \(section) (Current: \(riderNode.section)), animation duration: \(animationDuration/1000)")

        var followPath: CGPath!
        if riderNode.section != section {
            let nextTrackSection = track.trackSections[section]
            followPath = nextTrackSection.cgPath
        } else {
            followPath = track.trackSections[section].cgPath
        }

        if let start = track.trackSections[section].firstPoint() {
            riderNode.position = start
        }


//        let animation = SKAction.speed(by: 100, duration: animationDuration/1000)
        let animation = SKAction.follow(followPath, asOffset: false, orientToPath: true, duration: animationDuration/1000)
//        let animationAction = SKAction.follow(trackPath, duration: 3)
//        let animation = SKAction.speed(by: 200, duration: animationDuration/1000)
        riderNode.run(animation)

        // Update rider section
        riders[number]!.section = section
    }

    // MARK: - Gestures

    @objc func pinchGestureAction(_ sender: UIPinchGestureRecognizer) {
        guard let camera = self.camera else { return }
        
        if sender.state == .began {
            previousCameraScale = camera.xScale
        }
        camera.setScale(previousCameraScale * 1 / sender.scale)
    }

    // MARK: - Scroll scene

    override var minimumZoomScale: CGFloat {
        0.5
    }

}
