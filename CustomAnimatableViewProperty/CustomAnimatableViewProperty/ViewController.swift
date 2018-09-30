//
//  ViewController.swift
//  CustomAnimatableViewProperty
//
//  Created by wuweixin on 2018/9/30.
//  Copyright © 2018 wuweixin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func resetPressed(_ sender: Any) {
        progressView.progress = 0
        slider.setValue(0, animated: false)
    }
    
    @IBAction func loadPressed(_ sender: Any) {
        UIView.animate(withDuration: 2) {
            self.progressView.progress = 1
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        progressView.progress = CGFloat(slider.value)
    }
    
}

