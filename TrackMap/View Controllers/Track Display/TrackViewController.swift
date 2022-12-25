//
//  TrackViewController.swift
//  TrackMap
//
//  Created by Jack Perry on 24/12/2022.
//

import UIKit
import SnapKit
import SpriteKit
import Foundation

final class TrackViewController: UIViewController {

    private let useScrollView: Bool

    private lazy var spriteKitView: SKView = {
        let view = SKView(frame: .zero)
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 9
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var scrollContentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.addSubview(scrollContentView)
        return view
    }()

    private lazy var noteLabel: UILabel = {
        let view = PaddedLabel(withInsets: 16, 32, 8, 8)
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.adjustsFontForContentSizeCategory = true
        view.isHidden = true
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.backgroundColor = .systemYellow.withAlphaComponent(0.6)

        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 9
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.masksToBounds = true

        return view
    }()

    private lazy var sessionLabel: UILabel = {
        let view = PaddedLabel(withInsets: 8, 8, 8, 8)
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.adjustsFontForContentSizeCategory = true
        view.isHidden = true
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.backgroundColor = .white.withAlphaComponent(0.6)

        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 9
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true

        return view
    }()

    private var trackScene: TrackScene?

    private var competitors = Competitors()

    public var haveLoadedTrack: Bool {
        spriteKitView.scene != nil
    }

    // MARK: - Init

    public init(useScrollView: Bool) {
        self.useScrollView = useScrollView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "ViewController does not support NSCoding.")
    public required init?(coder: NSCoder) { notImplementedError() }

    // MARL: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureLayout()
        configureBindings()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.zoomScale = trackScene?.initialZoomScale ?? 1
        scrollViewDidZoom(scrollView)
    }

    // MARK: - Setup (private)

    private func configureView() {
        if useScrollView {
            view = spriteKitView
            view.addSubview(scrollView)
        } else {
            spriteKitView.addSubview(sessionLabel)
            spriteKitView.addSubview(noteLabel)
            view.addSubview(spriteKitView)
        }
    }

    private func configureLayout() {
        if useScrollView {
            scrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            spriteKitView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            sessionLabel.snp.makeConstraints { make in
                make.top.trailing.equalToSuperview()
            }

            noteLabel.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(80) // Initially lower for later animations
            }
        }
    }

    private func configureBindings() {

    }

    // MARK: - Configuration

    private func configurationDidUpdate() {
        // Update debug views
        let showDebugOverlay = UserDefaults.standard.showDebugOverlay
        spriteKitView.showsFPS = showDebugOverlay
        spriteKitView.showsNodeCount = showDebugOverlay
        spriteKitView.showsFields = showDebugOverlay
        spriteKitView.showsPhysics = showDebugOverlay
        spriteKitView.showsQuadCount = showDebugOverlay
        spriteKitView.showsDrawCount = showDebugOverlay

        // Track sections
        if haveLoadedTrack {
            let shouldDrawTrackSections = UserDefaults.standard.drawTrackSections
            let isDrawingTrackSections = trackScene?.drawingTrackSections

            if shouldDrawTrackSections != isDrawingTrackSections {
                trackScene?.drawTrackNodes(drawSections: shouldDrawTrackSections)
            }
        }

        let shouldUseTextures = UserDefaults.standard.useTextures
        if haveLoadedTrack, trackScene?.usingTextures != shouldUseTextures {
            trackScene?.toggleTextures(enabled: shouldUseTextures)
        }
    }

    // MARK: - Scroll helpers

    private func adjustScrollView(for scene: ScrollScene) {
        scrollView.maximumZoomScale = scene.maximumZoomScale
        scrollView.minimumZoomScale = scene.minimumZoomScale
        scrollView.zoomScale = scene.scale

        scrollContentView.frame = scene.rootNode.frame
        scrollView.contentSize = scrollContentView.frame.size

        scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - spriteKitView.bounds.height)
    }

    // MARK: - Track loading

    public func loadTrack(_ scene: TrackScene) {
        self.trackScene = scene

        if spriteKitView.scene != nil {
            (spriteKitView.scene as? ScrollScene)?.stopScene()
        }

        let transition = SKTransition.reveal(with: .up, duration: 2)
        self.spriteKitView.presentScene(scene, transition: transition)

        if useScrollView {
            adjustScrollView(for: scene)
        }
    }

}

// MARK: - Scroll view delegate

extension TrackViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomScrollViewInSKCoordinates = scrollView.contentOffset.y + spriteKitView.bounds.size.height
        let rootNodeY = -(scrollView.contentSize.height - bottomScrollViewInSKCoordinates)
        trackScene?.rootNode.position = CGPoint(x: -scrollView.contentOffset.x, y: rootNodeY)
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        trackScene?.rootNode.setScale(scrollView.zoomScale)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        scrollContentView
    }

}

// MARK: - Event update handlers

extension TrackViewController {

    public func handleNoteUpdate(_ update: NoteUpdate) {
        if update.message.isEmpty {
            // Animate hiding the label
            if noteLabel.isHidden == false {
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseInOut) { [unowned self] in
                    noteLabel.snp.updateConstraints { make in
                        make.bottom.equalToSuperview().offset(noteLabel.bounds.height + 16)
                    }
                    view.layoutIfNeeded()
                } completion: { [unowned self] _ in
                    noteLabel.isHidden = true
                }
            }

        } else {
            noteLabel.text = update.message

            // Animate displaying the label
            if noteLabel.isHidden {
                noteLabel.isHidden = false
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .curveEaseInOut) { [unowned self] in
                    noteLabel.snp.updateConstraints { make in
                        make.bottom.equalToSuperview().offset(16)
                    }
                    view.layoutIfNeeded()
                }
            }
        }
    }

    public func handleSessionUpdate(_ update: SessionUpdate) {
        sessionLabel.isHidden = false
        if update.runTime > 0 {
            sessionLabel.text = "\(update.status.flag) \(update.status)\n\(update.displayTime)"
        } else {
            sessionLabel.text = "\(update.status.flag) \(update.status)"
        }
    }

    public func handleRiderUpdate(_ update: RiderUpdate) {
        if UserDefaults.standard.singleRiderMode == true && update.riderNumber != 64 {
            return // Limit updates to Rider #64/
        }

        let prevSectionNumber = (update.currentSection == 0) ? (update.times?.count ?? 0) : update.currentSection
        let animationSection = update.currentSection + 1

        competitors.addSectionTime(update)
        competitors.addBetterTimes(update)

        let animationDuration = competitors.animationDuration(n: update.riderNumber, i: animationSection)

        DispatchQueue.main.async { [weak self] in
            self?.trackScene?.updateRider(update.riderNumber, section: update.currentSection, duration: animationDuration, timePassed: update.timePassed ?? 0)
        }
    }

}
