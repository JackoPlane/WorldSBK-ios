//
//  ViewController.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import UIKit
import SnapKit
import Combine
import SpriteKit
import InternalMenu
import SFSafeSymbols

class ViewController: UIViewController {

    private let hub = LiveTimingHub()
    private var cancellables = Set<AnyCancellable>()

    private let viewModel: ViewModel

    private lazy var trackView: UIView = {
        return UIView()
    }()
    private lazy var trackViewController: TrackViewController = {
        let viewController = TrackViewController(useScrollView: false)
        return viewController
    }()

    private func showCompetitorsContainer(_ traitCollection: UITraitCollection? = nil) -> Bool {
        if UIDevice.current.userInterfaceIdiom != .phone || (traitCollection ?? view.traitCollection).horizontalSizeClass != .compact {
            return true
        }

        return false
    }


    private lazy var competitorsContainer: UIView = {
        return UIView()
    }()

    private lazy var competitorsViewController: CompetitorsViewController = {
        let viewController = CompetitorsViewController()
        return viewController
    }()

    // Race replayer
    private var raceReplayer: RaceReplayer?

    private lazy var buttonStack: UIStackView = {
        let view = UIStackView(axis: .horizontal, distribution: .fillEqually, spacing: 8)
        return view
    }()

    private lazy var loadTrackButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        config.buttonSize = .large
        config.title = "Load Track"
        config.image = UIImage(systemSymbol: .map)
        config.imagePadding = 16

        return UIButton(configuration: config)
    }()

    private lazy var raceReplayButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemIndigo
        config.buttonSize = .large
        config.title = "Replay Race"
        config.image = UIImage(systemSymbol: .flagCheckered2Crossed)
        config.imagePadding = 16

        return UIButton(configuration: config)
    }()

    private lazy var arButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemYellow
        config.buttonSize = .large
        config.title = "ARKit"
        config.image = UIImage(systemSymbol: .arkit)
        config.imagePadding = 16

        return UIButton(configuration: config)
    }()

    private lazy var ridersButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemOrange
        config.buttonSize = .large
        config.title = "View Competitors"
        config.image = UIImage(systemSymbol: .listBullet)
        config.imagePadding = 16

        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 9
        view.layer.maskedCorners = [.layerMaxXMinYCorner]
        view.layer.masksToBounds = true

        return UIButton(configuration: config)
    }()

    // MARK: -

    @available(*, unavailable, message: "ViewController does not support NSCoding.")
    public required init?(coder: NSCoder) { notImplementedError() }

    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARL: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureLayout()
        configureBindings()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.horizontalSizeClass == .compact || UIDevice.current.userInterfaceIdiom == .phone {
            buttonStack.axis = .vertical
        } else {
            buttonStack.axis = .horizontal
        }

        let wasShowingCompetitors = showCompetitorsContainer(previousTraitCollection)
        let shouldShowCompetitors = showCompetitorsContainer(traitCollection)
        if wasShowingCompetitors != shouldShowCompetitors {

            // We need to show the view(s)
            if wasShowingCompetitors == false, shouldShowCompetitors == true {
                trackView.snp.makeConstraints { make in
                    make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(8)
                    make.bottom.equalTo(buttonStack.snp.top).offset(-8)
                    make.trailing.equalTo(competitorsContainer.snp.leading).inset(-8)
                }

                competitorsContainer.snp.updateConstraints { make in
                    make.top.trailing.equalTo(view.safeAreaLayoutGuide)
                    make.bottom.equalTo(buttonStack.snp.top).offset(-8)
                    make.width.lessThanOrEqualTo(300)
                }
            } else {
                trackView.snp.updateConstraints { make in
                    make.trailing.equalTo(competitorsContainer.snp.leading).inset(-8)
                }

                competitorsContainer.snp.updateConstraints { make in
                    make.size.equalTo(CGSize.zero)
                }
            }


        }

    }

    // MARK: - Helpers

    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            InternalMenu.instance.present(from: self)
        }
    }

    // MARK: - Setup (private)

    private func configureView() {
        title = "Track Visualiser"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", image: UIImage(systemSymbol: .gear), target: self, action: #selector(showSettingsTriggered(_:)))

        view.backgroundColor = .secondarySystemBackground

        // Scene view
        view.addSubview(trackView)
        add(childViewController: trackViewController, to: trackView)

        // Add the competitors controller if we're on iPad
        view.addSubview(competitorsContainer)
        add(childViewController: UINavigationController(rootViewController: competitorsViewController), to: competitorsContainer)

        // Unless we're using a compact size class or on iPhone, use horizontal layout
        if traitCollection.horizontalSizeClass == .compact || UIDevice.current.userInterfaceIdiom == .phone {
            buttonStack.axis = .vertical
        }
        view.addSubview(buttonStack)

        buttonStack.addArrangedSubview(loadTrackButton)
        buttonStack.addArrangedSubview(raceReplayButton)
        buttonStack.addArrangedSubview(arButton)

        if showCompetitorsContainer() == false {
            buttonStack.addArrangedSubview(ridersButton)
        }
    }

    private func configureLayout() {
        if showCompetitorsContainer() {
            trackView.snp.makeConstraints { make in
                make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(8)
                make.bottom.equalTo(buttonStack.snp.top).offset(-8)
                make.trailing.equalTo(competitorsContainer.snp.leading).inset(-8)
            }

            competitorsContainer.snp.makeConstraints { make in
                make.top.trailing.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalTo(buttonStack.snp.top).offset(-8)
                make.width.lessThanOrEqualTo(300)
            }

        } else {
            trackView.snp.makeConstraints { make in
                make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
                make.bottom.equalTo(buttonStack.snp.top).offset(-8)
            }

            competitorsContainer.snp.makeConstraints { make in
                make.size.equalTo(CGSize.zero)
            }
        }

        buttonStack.snp.makeConstraints { make in
            //make.top.equalTo(sceneView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }

    private func configureBindings() {
        loadTrackButton.addTarget(self, action: #selector(loadTrackPrimaryActionTriggered(_:)), for: .primaryActionTriggered)
        raceReplayButton.addTarget(self, action: #selector(startRaceReplayTriggered(_:)), for: .primaryActionTriggered)
        ridersButton.addTarget(self, action: #selector(displayCompetitorsTriggered), for: .primaryActionTriggered)

        hub.eventUpdates
            .sink(receiveValue: { [weak self] update in
                switch update {
                case .competitors(let update, _):
                    self?.competitorsViewController.updateCompetitors(update)
                case .note(let note, _):
                    self?.trackViewController.handleNoteUpdate(note)
                case .rider(let rider, _):
                    self?.trackViewController.handleRiderUpdate(rider)
                case .session(let session, _):
                    self?.trackViewController.handleSessionUpdate(session)
                case .event(let event, _):
                    print("EVENT UPDATE: \(event.name), race: \(event.race), Circuit: \(event.circuitName), session: \(event.session), sections: \(event.numberOfCircuitSections), trial: \(event.isTrialSession), weather: \(event.weather.conditions)")

                case .results:
                    print("Results update..")

                default:
                    break
                }

                self?.hubUpdate(update)
            }).store(in: &cancellables)
    }

    private func hubUpdate(_ update: HubEvent? = nil) {
        guard let update else { return }

        if case let .unsupported(type) = update {
            print("HUB Update: unsupported, type: \(type)")
        } else {
            print("HUB Update: \(update)")
        }
    }

    // MARK: - Actions

    @objc
    private func showSettingsTriggered(_ sender: UIBarButtonItem) {
        let controller = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: controller)

        navigationController.popoverPresentationController?.permittedArrowDirections = .up
        navigationController.popoverPresentationController?.barButtonItem = sender

        navigationController.modalPresentationStyle = .popover
        if let pres = navigationController.presentationController {
            pres.delegate = self
        }


        present(navigationController, animated: true, completion: nil)

        if let pop = navigationController.popoverPresentationController {
            pop.barButtonItem = sender
        }
    }

    @objc
    private func loadTrackPrimaryActionTriggered(_ sender: UIButton) {
        sender.configuration?.showsActivityIndicator = true
        sender.configuration?.title = "Loading.."

        if let scene = viewModel.loadTrack(.philipIsland) as? TrackScene {
            trackViewController.loadTrack(scene)
        }

        sender.configuration?.showsActivityIndicator = false
        sender.configuration?.title = "Load Track"
    }

    @objc
    private func startRaceReplayTriggered(_ sender: UIButton) {
        // Check the track has been loaded first..
        guard trackViewController.haveLoadedTrack != false else {
            let alertController = UIAlertController(title: "🚨 Unable to start replay 🚨", message: "A valid track is required before replay can begin", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .default))
            present(alertController, animated: true)

            return
        }

        // If we're already replaying, stop and update button
        if self.raceReplayer?.isReplaying == true {
            self.raceReplayer?.stop()
            self.raceReplayer = nil

            sender.configuration?.showsActivityIndicator = false
            sender.configuration?.title = "Replay Race"
        } else {
            sender.configuration?.showsActivityIndicator = true
            sender.configuration?.title = "Replaying.."
        }

        // Load the replayer
        self.raceReplayer = RaceReplayer(fileName: "ReplayRaceOnly")

        self.raceReplayer?.start(withHub: hub)
    }

    @objc private func displayCompetitorsTriggered() {
        guard UIDevice.current.userInterfaceIdiom == .phone else { return }

        present(UINavigationController(rootViewController: competitorsViewController), animated: true)
    }

}

// MARK: - Popover delegate

extension ViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }

}


extension UIViewController {

    /// Utility method to add a `UIViewController` instance to a `UIView`.
    ///
    /// Calls all necessary methods for adding a child view controller and set the constraints
    /// between the views.
    ///
    /// - Parameters:
    ///   - viewController: `UIViewController` instance that will be added to `contentView`.
    ///   - contentView: `UIView` that will add the `childViewController` as its subview.
    func add(childViewController viewController: UIViewController, to contentView: UIView) {
        let matchParentConstraints = [
            viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]

        addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(viewController.view)
        NSLayoutConstraint.activate(matchParentConstraints)
        viewController.didMove(toParent: self)
    }
}
