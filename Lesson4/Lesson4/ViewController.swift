//
//  ViewController.swift
//  Lesson4
//
//  Created by Михаил Парсуков on 14.12.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = 1
        
        //label.isHidden = true
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

}

