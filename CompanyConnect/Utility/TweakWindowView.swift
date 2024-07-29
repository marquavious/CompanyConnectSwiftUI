//
//  TweakWindowView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/26/24.
//

import Foundation
import SwiftUI

struct TweakWindowView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Button("Dismiss") {
                dismiss()
            }
            TweakWindowUIViewControllerRepresentable()
        }
        .padding([.vertical])
    }
}

#Preview {
    TweakWindowView()
}

struct TweakWindowUIViewControllerRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        return UIViewControllerTweakWindow()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No-Op
    }

}

class UIViewControllerTweakWindow: UIViewController {

    private let tweakManager = CCTweakManager.shared
    private var selectedTweak: CCTweaks?

    private lazy var tweakManagerTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()

    private lazy var pickerContainerView: UIView = {
        let pickerView = UIView(frame: CGRect(x: 0, y: view.frame.height + 260, width: view.frame.width, height: 260))
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private lazy var picker: UIPickerView = {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 260))
        picker.isUserInteractionEnabled = true
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
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
            pickerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pickerContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 260),
            pickerContainerView.heightAnchor.constraint(equalToConstant: 260)
        ])

        pickerContainerView.addSubview(picker)
        pickerContainerView.addSubview(toolBar)
    }

    private func appearPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerContainerView.frame = CGRect(x: 0, y: self.view.bounds.height - self.pickerContainerView.bounds.size.height, width: self.pickerContainerView.bounds.size.width, height: self.pickerContainerView.bounds.size.height)
        })
    }

    private func hidePickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerContainerView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.pickerContainerView.bounds.size.width, height: self.pickerContainerView.bounds.size.height)
        })
    }

    private func showPickerView() {
        hightlightSelectedTweakOption()
        appearPickerView()
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
        40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let unwrappedSelectedTweak = CCTweaks(rawValue: indexPath.row) else {
            fatalError("Attempted to create CCTweak from non-existant option")
        }
        selectedTweak = unwrappedSelectedTweak
        tableView.deselectRow(at: indexPath, animated: true)
        picker.reloadAllComponents()
        showPickerView()
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
