//
//  ViewController.swift
//  Lesson8
//
//  Created by Михаил Парсуков on 18.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var uiElements = ["UISegmentControl",
    "UILabel",
    "UISlaider",
    "UITextField",
    "UIButton",
    "UIDatePicker"]

    var selectedElement: String?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = 1
        
        label.text = String(slider.value)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: segmentedControl.numberOfSegments, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        choiceElement()
        createToolbar()
    }
    
    func hideAllElements() {
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
    }
    
    func choiceElement() {
        
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        textField.inputView = elementPicker
        
        // Customization
        elementPicker.backgroundColor = .brown
    }
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButtonItem = UIBarButtonItem(title: "Done",
                                             style: .plain,
                                             target: self,
                                             action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButtonItem], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar // надстройка над клавиатурой
        
        // Customization
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        
        switch sender.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        case 1:
            label.text = "The second segment is selected"
            label.textColor = .blue
        case 2:
            label.text = "The third segment is selected"
            label.textColor = .yellow
        default:
            print("Something wrong")
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        guard textField.text?.isEmpty == false else { return }
        
        let str = textField.text!
        var wrong = false
        for c in str {
            if let _ = Double(String(c)) {
                wrong = true
                break
            }
        }
        
        if wrong {
            
            let alert = UIAlertController(title: "Wrong format", message: "Please enter your name", preferredStyle: .alert)
            alert.addTextField{ (alertTextField: UITextField!) -> Void in
                alertTextField.placeholder = "Enter your name"
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                let textField = (alert.textFields![0] as UITextField)
                self.label.text = textField.text
                self.textField.text = nil
            })
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
            
            print("Name format is wrong")
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }

    @IBAction func changeDate(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let dateValue = dateFormatter.string(from: sender.date)
        
        label.text = dateValue
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        
        segmentedControl.isHidden = sender.isOn
        label.isHidden = sender.isOn
        slider.isHidden = sender.isOn
        textField.isHidden = sender.isOn
        doneButton.isHidden = sender.isOn
        datePicker.isHidden = sender.isOn
        
        if sender.isOn {
            switchLabel.text = "Отобразить все элементы"
        } else {
            switchLabel.text = "Скрыть все элементы"
        }
    }
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        hideAllElements()
        
        switch row {
        case 0:
            segmentedControl.isHidden = false
        case 1:
            label.isHidden = false
        case 2:
            slider.isHidden = false
        case 3:
            print("nothing to hide")
        case 4:
            doneButton.isHidden = false
        case 5:
            datePicker.isHidden = false
        default:
            print("")
        }
    }
 
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLabel.text = uiElements[row]
        
        return pickerViewLabel
    }
}
