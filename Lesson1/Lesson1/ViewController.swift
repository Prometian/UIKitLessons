//
//  ViewController.swift
//  Lesson1
//
//  Created by Михаил Парсуков on 13.12.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet var actionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.isHidden = true
        label.font = label.font.withSize(35)
        label.textColor = .red
        
        button.isHidden = true
        
        for button in actionButtons {
            button.setTitleColor(.blue, for: .normal)
            button.backgroundColor = .green
        }
        
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
    }

    @IBAction func pressedButton(_ sender: UIButton) {
        label.isHidden = false
        button.isHidden = false
        
        switch sender.tag {
        case 0:
            label.text = "Hello, World"
            label.textColor = .red
        case 1:
            label.text = "Hi there!"
            label.textColor = .blue
        case 2:
            label.isHidden = true
            button.isHidden = true
        default: break
        }
    }

}

