//
//  ViewController.swift
//  spacePhoto
//
//  Created by Chinonso Obidike on 3/19/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageDescLabel: UILabel!
    
    @IBOutlet weak var copyrightlabel: UILabel!
    
   
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view")
        // Do any additional setup after loading the view, typically from a nib.
        imageDescLabel.text = ""
        copyrightlabel.text = ""
        print("label")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        photoInfoController.fetchPhotoInfo{ (photoInfo: PhotoInfo?) in
            if let photoInfo = photoInfo {
                    print("dispatch")
                self.updateUI(with: photoInfo)
                }
            }
        }

    func updateUI(with photoInfo: PhotoInfo) {
        print("photo")
        guard let url = photoInfo.url.withHTTPS() else {
            return
        }
        let task = URLSession.shared.dataTask(with: url,
                  completionHandler: {
                    (data: Data?, response: URLResponse?, error: Error?) in
                    guard let data = data else {
                        return
                    }
                    
                    switch photoInfo.mediaType {
                    case "video":
                        DispatchQueue.main.async {
                            UIApplication.shared.open(photoInfo.url) {(b: Bool) in
                                print("opened b: \(b)")
                              UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                        }
                    case "image":
                        guard let image = UIImage(data: data) else {
                            return
                        }
                        DispatchQueue.main.async {
                            self.title = photoInfo.title
                            self.imageView.image = image
                            self.imageDescLabel.text = photoInfo.description
                            
                            if let copyright = photoInfo.copyright {
                                self.copyrightlabel.text = "Copyright \(copyright)"
                            } else {
                                self.copyrightlabel.isHidden = true
                            }
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    default:
                        fatalError()
                    }
        })
                     task.resume()
        }
        }

   
 


