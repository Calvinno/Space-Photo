//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Calvin Cantin on 2019-02-06.
//  Copyright © 2019 Calvin Cantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var photoTitleNavigationItem: UINavigationItem!
    @IBOutlet weak var photoOfTheDayImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = ""
        copyrightLabel.text = ""
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo
            {
                updateUI(with: photoInfo)
        }
    }
    func updateUI(with photoInfo: PhotoInfo)
    {
        let task = URLSession.shared.dataTask(with: photoInfo.url) { (data, response, error) in
            
            if let data = data, let image = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.photoTitleNavigationItem.title = photoInfo.title
                    self.descriptionTextView.text = photoInfo.description
                    self.photoOfTheDayImageView.image = image
                    if let copyright = photoInfo.copyright
                    {
                        self.copyrightLabel.text = "copyright \(copyright)"
                    }
                    else
                    {
                        self.copyrightLabel.isHidden = true
                    }
                }
            }
        }
        task.resume()
    }
}

}
