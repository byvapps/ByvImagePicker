//
//  ByvImagePicker.swift
//  Pods
//
//  Created by Adrian Apodaca on 30/12/16.
//
//

import Foundation
import UIKit
import ByvUtils
import TOCropViewController

public typealias ByvImagePickerCompletion = (UIImage?) -> Void
public typealias ByvFrom = (controller:UIViewController, from:CGRect, inView:UIView, arrowDirections:UIPopoverArrowDirection)

public class ByvImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate {
    
    var pickerCompletion:ByvImagePickerCompletion? = nil
    var imagePicker:UIImagePickerController
    var editable:Bool = false
    var isCircle:Bool = false
    var customAspectRatio:CGSize? = nil
    
    override public init() {
        imagePicker = UIImagePickerController()
        super.init()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    // MARK: - Public methods
    
    public func getEditableImage(from:ByvFrom, completion: @escaping ByvImagePickerCompletion) {
        getImage(from: from, editable: true, isCircle: false, customAspectRatio: nil, completion: completion)
    }
    
    public func getFixedImage(from:ByvFrom, customAspectRatio:CGSize, completion: @escaping ByvImagePickerCompletion) {
        getImage(from: from, editable: true, isCircle: false, customAspectRatio: customAspectRatio, completion: completion)
    }
    
    public func getCircularImage(from:ByvFrom, completion: @escaping ByvImagePickerCompletion) {
        getImage(from: from, editable: true, isCircle: true, customAspectRatio: nil, completion: completion)
    }
    
    public func getImage(from:ByvFrom, editable:Bool = false, isCircle:Bool = false, customAspectRatio:CGSize? = nil, completion: @escaping ByvImagePickerCompletion) {
        self.editable = editable
        self.isCircle = isCircle
        self.customAspectRatio = customAspectRatio
        let av = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        pickerCompletion = completion
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            av.addAction(UIAlertAction(title: NSLocalizedString("Sacar foto", comment:""), style: .default, handler: { (action) in
                self.getCameraImage(from: from.controller, completion: completion)
            }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            av.addAction(UIAlertAction(title: NSLocalizedString("Imagen de mi galería", comment:""), style: .default, handler: { (action) in
                self.getLibraryImage(from: from, completion: completion)
            }))
        }
        av.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: ""), style: .cancel, handler: { (action) in
            completion(nil)
            av.dismiss(animated: true, completion: nil)
        }))
        
        from.controller.present(av, animated: true, completion: nil)
    }
    
    public func getCameraImage(from:UIViewController, editable:Bool, isCircle:Bool, customAspectRatio:CGSize? = nil, completion: @escaping ByvImagePickerCompletion) {
        self.editable = editable
        self.isCircle = isCircle
        self.customAspectRatio = customAspectRatio
        getCameraImage(from: from, completion: completion)
    }
    
    public func getLibraryImage(from:ByvFrom, editable:Bool, isCircle:Bool, customAspectRatio:CGSize? = nil, completion: @escaping ByvImagePickerCompletion) {
        self.editable = editable
        self.isCircle = isCircle
        self.customAspectRatio = customAspectRatio
        getLibraryImage(from: from, completion: completion)
    }
    
    // MARK: - Private Methods
    
    func getCameraImage(from:UIViewController, completion: @escaping ByvImagePickerCompletion) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            from.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func getLibraryImage(from:ByvFrom, completion: @escaping ByvImagePickerCompletion) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            if UIDevice.current.userInterfaceIdiom == .pad {
                imagePicker.modalPresentationStyle = .popover
                imagePicker.popoverPresentationController?.sourceRect = from.from
                imagePicker.popoverPresentationController?.sourceView = from.inView
                imagePicker.popoverPresentationController?.permittedArrowDirections = from.arrowDirections
                from.controller.present(imagePicker, animated: true, completion: nil)
            } else {
                pickerCompletion = completion
                from.controller.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if self.editable {
            if let img = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                if self.isCircle {
                    let controller = TOCropViewController(croppingStyle: .circular, image: img)
                    controller.delegate = self
                    picker.pushViewController(controller, animated: false)
                } else {
                    let controller = TOCropViewController(image: img)
                    controller.delegate = self
                    if let ar = self.customAspectRatio {
                        controller.customAspectRatio = ar
                        controller.resetAspectRatioEnabled = false
                        controller.aspectRatioLockEnabled = true
                        controller.rotateButtonsHidden = true
                    }
                    picker.pushViewController(controller, animated: false)
                }
                return
            }
        }
        if let comp = pickerCompletion {
            let ori = info["UIImagePickerControllerOriginalImage"] as? UIImage
            comp(ori)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if let comp = pickerCompletion {
            comp(nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TOCropViewControllerDelegate methods
    
    public func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        if let comp = pickerCompletion {
            comp(image)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    public func cropViewController(_ cropViewController: TOCropViewController, didCropToCircleImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        if let comp = pickerCompletion {
            comp(image)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    public func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        if let comp = pickerCompletion {
            comp(nil)
        }
        if cancelled {
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}

