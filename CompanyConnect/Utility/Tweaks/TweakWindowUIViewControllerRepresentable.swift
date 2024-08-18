//
//  TweakWindowUIViewControllerRepresentable.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/6/24.
//

import Foundation
import SwiftUI


struct TweakWindowUIViewControllerRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        return UIViewControllerTweakWindow()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No-Op
    }

}

final class UIViewControllerTweakWindow: UIViewController {

    struct Constants {
        static let pickerHeight: CGFloat = 260
        static let toolbarHeight: CGFloat = 35
        static let tableCellHeight: CGFloat = 40
    }

    private let tweakManager = CCTweakManager.shared
    private var selectedTweak: CCTweaks?

    private lazy var hidePickerViewContainerTopConstraint = pickerContainerView.topAnchor.constraint(equalTo: view.bottomAnchor)

    private lazy var tweakManagerTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()

    private lazy var pickerContainerView: UIView = {
        let pickerView = UIView()
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.isUserInteractionEnabled = true
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonPressed))
        toolBar.setItems([button], animated: true)
        return toolBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(tweakManagerTableView)
        NSLayoutConstraint.activate([
            tweakManagerTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tweakManagerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tweakManagerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tweakManagerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        view.addSubview(pickerContainerView)
        NSLayoutConstraint.activate([
            hidePickerViewContainerTopConstraint,
            pickerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pickerContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerContainerView.heightAnchor.constraint(equalToConstant: Constants.pickerHeight)
        ])

        pickerContainerView.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: pickerContainerView.bottomAnchor),
            picker.topAnchor.constraint(equalTo: pickerContainerView.topAnchor)
        ])

        pickerContainerView.addSubview(toolBar)
        NSLayoutConstraint.activate([
            toolBar.leadingAnchor.constraint(equalTo: pickerContainerView.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: pickerContainerView.trailingAnchor),
            toolBar.topAnchor.constraint(equalTo: pickerContainerView.topAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: Constants.toolbarHeight)
        ])
    }

    private func showPickerView() {
        hidePickerViewContainerTopConstraint.isActive = false
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }

    private func hidePickerView() {
        hidePickerViewContainerTopConstraint.isActive = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }

    private func shouldShowPickerView() {
        hightlightSelectedTweakOption()
        showPickerView()
    }

    private func tweakValueTitleFor(row: Int) -> String {
        guard let tweak = CCTweaks(rawValue: row) else { fatalError() }
        switch tweak {
        case .internetSpeed:
            return tweak.currentConfigurationTitle
        }
    }

    private func hightlightSelectedTweakOption() {
        guard let selectedTweak else { return }
        var rowValue = 0

        switch selectedTweak {
        case .internetSpeed:
            if let tweakValue = tweakManager.retreiveTweakValue(tweak: .internetSpeed).value as? TimeInterval,
               let tweak = InternetSpeedTweak(value: tweakValue) { rowValue = tweak.rawValue }
        }

        picker.selectRow(
            rowValue,
            inComponent: 0,
            animated: false
        )
    }

    private func saveSelectedTweekSetting() {
        guard let selectedTweak else { return }
        switch selectedTweak {
        case .internetSpeed:
            guard let value = InternetSpeedTweak(rawValue: picker.selectedRow(inComponent: 0))?.value else {
                fatalError("Attempted to create InternetSpeedTweak from non-existant option")
            }
            tweakManager.saveTweakValue(
                tweak: selectedTweak,
                value: value
            )
        }
    }

    @objc private func doneButtonPressed() {
        view.endEditing(true)
        saveSelectedTweekSetting()
        hidePickerView()
        tweakManagerTableView.reloadData()
    }
}

extension UIViewControllerTweakWindow: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CCTweaks.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = "\(CCTweaks.allCases[row].title): \(tweakValueTitleFor(row: row))"
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableCellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let unwrappedSelectedTweak = CCTweaks(rawValue: indexPath.row) else {
            fatalError("Attempted to create CCTweak from non-existant option")
        }
        selectedTweak = unwrappedSelectedTweak
        tableView.deselectRow(at: indexPath, animated: true)
        picker.reloadAllComponents()
        shouldShowPickerView()
    }
}

extension UIViewControllerTweakWindow: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        selectedTweak?.options.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedTweak?.options[String(row)]
    }
}
