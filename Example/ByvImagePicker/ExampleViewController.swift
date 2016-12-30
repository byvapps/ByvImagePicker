//
//  ExampleViewController.swift
//  ByvImagePicker
//
//  Created by Adrian Apodaca on 30/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import ByvImagePicker

class ExampleViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var picker:ByvImagePicker? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pickImage(_ sender: UIButton) {
        if picker == nil {
            picker = ByvImagePicker()
        }
        let from = ByvFrom(controller: self, from:sender.frame, inView:self.view, arrowDirections:.any)
        picker!.getImage(from: from, completion: { image in
            self.imageView.image = image
        })
    }
    
    @IBAction func pickAndEdit(_ sender: UIButton) {
        if picker == nil {
            picker = ByvImagePicker()
        }
        let from = ByvFrom(controller: self, from:sender.frame, inView:self.view, arrowDirections:.any)
        picker!.getEditableImage(from: from, completion: { image in
            self.imageView.image = image
        })
    }
    
    @IBAction func pickAndCrop(_ sender: UIButton) {
        if picker == nil {
            picker = ByvImagePicker()
        }
        let from = ByvFrom(controller: self, from:sender.frame, inView:self.view, arrowDirections:.any)
        picker!.getFixedImage(from: from, customAspectRatio: imageView.bounds.size, completion: { image in
            self.imageView.image = image
        })
    }
    
    
    @IBAction func pickProfile(_ sender: UIButton) {
        if picker == nil {
            picker = ByvImagePicker()
        }
        let from = ByvFrom(controller: self, from:sender.frame, inView:self.view, arrowDirections:.any)
        picker!.getCircularImage(from: from, completion: { image in
            self.profileImage.image = image
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
