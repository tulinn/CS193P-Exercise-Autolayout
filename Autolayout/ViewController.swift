//
//  ViewController.swift
//  Autolayout
//
//  Created by Tulin Akdogan on 4/5/15.
//  Copyright (c) 2015 Tulin Akdogan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var loggedInUser: User?{ didSet{ updateUI() } }
    var secure: Bool =  false{
        didSet{ updateUI() } }
    
    private func updateUI(){
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
    }
    
    var image: UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            if let constrainedView = imageView{
                if let newImage = newValue{
                    aspectRatioConstraint = NSLayoutConstraint(item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                }
                else{
                    aspectRatioConstraint =  nil
                }
            }
        }
    }
    var aspectRatioConstraint: NSLayoutConstraint?{
        willSet{
            if let existingConstraint = aspectRatioConstraint{
                view.removeConstraint(existingConstraint)
            }
        }
        didSet{
            if let newConstraint = aspectRatioConstraint{
                view.addConstraint(newConstraint)
            }
        }
    }

    
    @IBAction func toggleSecurity(sender:
        UIButton) {
            secure = !secure
    }
    
    @IBAction func login(sender: UIButton) {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
}

extension User{
    var image: UIImage?{
        if let image = UIImage(named: login){
            return image
        }
        else{
            return UIImage(named: "unknown_user")
        }
    }
}

extension UIImage{
    var aspectRatio: CGFloat{
        return size.height != 0 ? size.width / size.height : 0
    }
}