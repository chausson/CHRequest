//
//  ViewController.swift
//  CHNetwork-Example
//
//  Created by Chausson on 2017/2/21.
//  Copyright © 2017年 Chausson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pic: UIImageView!
    let lRequest = LoginRequest<User>(userName: "18116342840", password: "123456")
    let lAPI = LoginAPI(userName: "18116342840", password: "123456")
    
    let data = ["Noraml Request","JSON Reuqest","Download Reuqest","Upload Request"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func normalRequest() {
        lAPI.request { result in
            if case let .success(response) = result {
                print("\nStr = \(String(describing: response.jsonString))")
            }
            if case let .failure(error) = result{
                print("\nDebug = \(error.response.debugDescription)")
            }
            
        }
    }
    func jsonRequest() {
        lRequest.requestJSON { user in
            print("\nUser = \(String(describing: user))")
        }
    }
    func downloadRequest() {
        let imageAPI = ImageDownloadAPI()
        imageAPI.download(progressClosure: { (progress) in
            print("Download Progress:\(progress.completedUnitCount)\n All Data:\(progress.totalUnitCount)")
        }) { [weak self] (data,url) in
            debugPrint("[Download destinationURL:\(url)]")
            let image = UIImage(data: data)
            self?.pic.image = image
        }
    }
    func uploadRequest() {
        
        guard let image = UIImage(named:"selena") else {
            return
        }
        let data = UIImageJPEGRepresentation(image, 0.9)
        let uploadImage = CHUploadImage(data!)
        uploadImage.upload(progressClosure: { (progress) in
                    print("Upload Progress:\(progress.completedUnitCount)")
        }) { (result) in
                if case let .success(response) = result{
                    print("Upload Response:\(String(describing: response.jsonString))")
  
                }
        }

    }
}
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            normalRequest()
        case 1:
            jsonRequest()
        case 2:
            downloadRequest()
        case 3:
            uploadRequest()
        default:
            print("do nothing")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}


