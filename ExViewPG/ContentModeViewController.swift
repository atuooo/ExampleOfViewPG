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
    
    @IBAction func clipSwitch(sender: AnyObject) {
        imageView.clipsToBounds = (sender as! UISwitch).on
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

    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 需要等 imageView 加载完才能获取到其 准确的frame，不然只是在storyboard中的frame
        let auxiliaryLine = AuxiliaryLine(frame: imageView.frame)
        self.view.addSubview(auxiliaryLine)
    }
}

extension ContentModeViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMode = row
    }
}
