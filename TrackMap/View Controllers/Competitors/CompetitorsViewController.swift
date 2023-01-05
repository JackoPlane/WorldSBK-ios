//
//  CompetitorsViewController.swift
//  TrackMap
//
//  Created by Jack Perry on 26/12/2022.
//

import UIKit
import Foundation

final class CompetitorsViewController: UIViewController {

    private var competitors: [CompetitorUpdate] = []

    private var dataSource: UICollectionViewDiffableDataSource<Section, CompetitorUpdate>!

    private lazy var collectionView: UICollectionView = {
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)

        let view = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        view.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

        return view
    }()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "CompetitorsViewController does not support NSCoding.")
    public required init?(coder: NSCoder) { notImplementedError() }


    private enum Section: CaseIterable {
        case main
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Competitors"

        configureView()
        configureLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if competitors.count > 0 {
            updateCompetitors(competitors)
        }
    }

    // MARK: - Setup (private)

    private func configureView() {
        view.addSubview(collectionView)

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CompetitorUpdate> { cell, indexPath, competitor in
            var content = cell.defaultContentConfiguration()
            content.text = "\(competitor.position) - \(competitor.riderNumber) \(competitor.firstName) \(competitor.surname)"
            content.secondaryText = "\(competitor.team) (\(competitor.brand) \(competitor.motorcycle))"
            cell.contentConfiguration = content
        }

        dataSource = UICollectionViewDiffableDataSource<Section, CompetitorUpdate>(collectionView: collectionView) { (collectionView, indexPath, country) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: country)
          }
    }

    private func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview()
        }
    }

    // MARK: - Updates

    public func updateCompetitors(_ competitors: [CompetitorUpdate]) {
        self.competitors = competitors

        if view.superview != nil {
            var snapshot = NSDiffableDataSourceSnapshot<Section, CompetitorUpdate>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(competitors)
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }


}

//extension CompetitorsViewController: UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        competitors.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewListCell
//
//        let competitor = competitors[indexPath.row]
//        let config = cell.defaultContentConfiguration()
//        config.text = competitor.firstName
//        cell.updat
//
//        return cell
//    }
//
//}
