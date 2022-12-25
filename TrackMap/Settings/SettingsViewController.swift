//
//  SettingViewController.swift
//  TrackMap
//
//  Created by Jack Perry on 23/12/2022.
//

import UIKit
import Foundation

enum SettingsEnum: String, CaseIterable {
    case drawTrackSections
    case enableDebugViews
    case useTextures
    case debugMasterTrackNode
    case singleRiderMode

    var title: String {
        switch self {
        case .drawTrackSections: return "Draw track sections"
        case .enableDebugViews: return "Enable debug views"
        case .useTextures: return "Use Textures"
        case .debugMasterTrackNode: return "Debug master track"
        case .singleRiderMode: return "Single rider mode"
        }
    }

    var value: Any {
        switch self {
        case .drawTrackSections: return UserDefaults.standard.drawTrackSections
        case .enableDebugViews: return UserDefaults.standard.showDebugOverlay
        case .useTextures: return UserDefaults.standard.useTextures
        case .debugMasterTrackNode: return UserDefaults.standard.debugMasterTrackNode
        case .singleRiderMode: return UserDefaults.standard.singleRiderMode
        }
    }


    func set(value: Any) {
        switch self {
        case .drawTrackSections: return UserDefaults.standard.drawTrackSections = value as! Bool
        case .enableDebugViews: return UserDefaults.standard.showDebugOverlay = value as! Bool
        case .useTextures: return UserDefaults.standard.useTextures = value as! Bool
        case .debugMasterTrackNode: return UserDefaults.standard.debugMasterTrackNode = value as! Bool
        case .singleRiderMode: return UserDefaults.standard.singleRiderMode = value as! Bool
        }
    }

}


class SettingsViewController: UITableViewController {

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()

        title = "Settings"

        tableView.register(SettingsSwitchTableViewCell.self, forCellReuseIdentifier: "switch-cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if modalPresentationStyle != .pageSheet {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(_:)))
        }
    }

    // MARK: - Actions

    @objc
    func doneButtonPressed(_ control: UIControl?) {
        navigationController?.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsEnum.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = UITableViewCell()

        let setting = SettingsEnum.allCases[indexPath.row]
        if let value = setting.value as? Bool {
            cell = tableView.dequeueReusableCell(withIdentifier: "switch-cell", for: indexPath)

            cell.textLabel?.text = setting.title
            (cell as? SettingsSwitchTableViewCell)?.switchControl.isOn = value
        } else if setting.value is String {
            cell.textLabel?.text = setting.title
        }


        return cell
    }

    // MARK: - Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let setting = SettingsEnum.allCases[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        if let value = (cell as? SettingsSwitchTableViewCell)?.switchControl.isOn {
            setting.set(value: value)
        }

    }

}

private class SettingsSwitchTableViewCell: UITableViewCell {

    let switchControl = UISwitch()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryView = switchControl
        switchControl.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    @objc
    private func switchToggled(_ sender: UISwitch) {
        guard let tableView = tableView, let indexPath = tableView.indexPath(for: self) else { return }

        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }

    private var tableView: UITableView? {
        var view = superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        return view as? UITableView
    }
}
