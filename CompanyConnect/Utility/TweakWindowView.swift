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
            TweakWindowViewStruct()
        }
    }
}

#Preview {
    TweakWindowView()
}

struct TweakWindowViewStruct: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIViewControllerTweakWindow()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No-Op
    }

}

class UIViewControllerTweakWindow: UIViewController {

    let tweakManager = CCTweakManager.shared

    lazy var tweakManagerTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    var pickerView: UIView!
    var picker: UIPickerView!

    var selectedTweak = InternetSpeedTweak(rawValue: 0)!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        tweakManagerTableView.delegate = self
        tweakManagerTableView.dataSource = self

        view.addSubview(tweakManagerTableView)

        NSLayoutConstraint.activate([
            tweakManagerTableView.topAnchor.constraint(equalTo: view.topAnchor),
            tweakManagerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tweakManagerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tweakManagerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true

        pickerView = UIView(frame: CGRect(x: 0, y: view.frame.height + 260, width: view.frame.width, height: 260))

        view.addSubview(pickerView)

        pickerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pickerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 260),
            pickerView.heightAnchor.constraint(equalToConstant: 260)
        ])

        pickerView.backgroundColor = .white

        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 260))
        pickerView.addSubview(picker)

        picker.isUserInteractionEnabled = true
        pickerView.addSubview(toolBar)

        picker.delegate = self
        picker.dataSource = self
    }

    func appearPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height - self.pickerView.bounds.size.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
        })
    }

    func disappearPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
        })
    }

    func setupPicker(){
        let pickerView = UIPickerView()
        pickerView.delegate = self

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()

        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
    }

    func appearPickerAction() {
        appearPickerView()
    }

    @objc func done() {
        view.endEditing(true)
        tweakManagerTableView.reloadData()
        disappearPickerView()
    }
}

extension UIViewControllerTweakWindow: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Tweaks.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = "\(Tweaks.allCases[row].displayName): \(tweakValueNameForRow(row: row))"
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        appearPickerAction()
    }

    private func tweakValueNameForRow(row: Int) -> String {
        guard let tweak = Tweaks(rawValue: row) else { fatalError() }
        switch tweak {
        case .internetSpeed:
            return CCTweakManager.shared.retreiveTweakValue(tweak: .internetSpeed).displayName
        }
    }

}

extension UIViewControllerTweakWindow: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        InternetSpeedTweak.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        InternetSpeedTweak.allCases[row].displayName
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CCTweakManager.shared.saveTweakValue(tweak: Tweaks.internetSpeed, value: row)
    }
}
