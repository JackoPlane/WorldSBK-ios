////
////  File.swift
////  TrackMap
////
////  Created by Jack Perry on 26/12/2022.
////
//
//import UIKit
//import Foundation
//
//struct CompetitorContentConfiguration: UIContentConfiguration, Hashable {
//
//    func makeContentView() -> UIView & UIContentView {
//        CompetitorHorizontalContentView(configuration: self)
//    }
//
//    func updated(for state: UIConfigurationState) -> CompetitorContentConfiguration {
//        
//    }
//
//}
//
//class CompetitorHorizontalContentView: UIView, UIContentView {
//
//    init(configuration: CompetitorContentConfiguration) {
//        super.init(frame: .zero)
//
//        configureView()
//        configureLayout()
//
//        apply(configuration: configuration)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Configuration
//    private var currentConfiguration: CompetitorContentConfiguration!
//    var configuration: UIContentConfiguration {
//        get {
//            currentConfiguration
//        }
//        set {
//            // Make sure the given configuration is of type CompetitorContentConfiguration
//            guard let newConfiguration = newValue as? CompetitorContentConfiguration else {
//                return
//            }
//
//            // Apply the new configuration to CompetitorHorizontalContentView
//            // also update currentConfiguration to newConfiguration
//            apply(configuration: newConfiguration)
//        }
//    }
//
//    // MARK: - Private
//
//    private func configureView() {
//
//    }
//
//    private func configureLayout() {
//
//    }
//
//    private func apply(configuration: CompetitorContentConfiguration) {
//        // Only apply configuration if new configuration and current configuration are not the same
//        guard currentConfiguration != configuration else {
//            return
//        }
//
//        // Replace current configuration with new configuration
//        currentConfiguration = configuration
//
//        
//    }
//
//}
//
//final class CompetitorCollectionViewListCell: UICollectionViewListCell {
//
//    var competitor: CompetitorUpdate?
//
//    override func updateConfiguration(using state: UICellConfigurationState) {
//
//    }
//
//
//}
