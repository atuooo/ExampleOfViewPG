//
//  ContentModeViewController.swift
//  ExViewPG
//
//  Created by Atuooo on 12/27/15.
//  Copyright © 2015 xyz. All rights reserved.
//

import UIKit

class ContentModeViewController: UIViewController {
    
    var modes = ["ScaleToFill", "ScaleAspectFit", "ScaleAspectFill", "Redraw", "Center", "Top", "Bottom", "Left", "Right", "TopLeft", "TopRight", "BottomLeft", "BottomRight"]
    
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func clipSwitch(_ sender: AnyObject) {
        imageView.clipsToBounds = (sender as! UISwitch).isOn
    }
    
    var selectedMode: Int = 0 {
        didSet {
            imageView.contentMode = UIViewContentMode(rawValue: selectedMode)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self

        imageView.image = UIImage(named: "kodama")
        
//        imageView.layer.borderWidth = 3.0
//        imageView.layer.borderColor = UIColor.yellowColor().CGColor
    }
    
    override func viewDidLayoutSubviews() {
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let auxiliaryLine = AuxiliaryLine(frame: imageView.frame)
        view.addSubview(auxiliaryLine)
    }
}

extension ContentModeViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMode = row
    }
}
