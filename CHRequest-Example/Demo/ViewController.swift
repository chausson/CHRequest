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
    let l = LoginRequest<User>(userName: "18116342840", password: "123456")
    let data = ["Noraml Request","JSON Reuqest","Download Reuqest"]
    override func viewDidLoad() {
        super.viewDidLoad()
        config.add(["password":"OOOXXXXX"])
    }
    func normalRequest() {
        l.request { result in
            if case let .success(response) = result {
                print("\nStr = \(response.jsonString)")
            }
            if case let .failure(error) = result{
                print("\nDebug = \(error.response.debugDescription)")
            }
            
        }
    }
    func jsonRequest() {
        l.requestJSON { user in
            print("\nUser = \(user)")
        }
    }
    func downloadRequest() {
        let imageAPI = ImageDownloadAPI()
        imageAPI.download(progressClosure: { (progress) in
            print("Download Progress:\(progress.completedUnitCount)\n All Data:\(progress.totalUnitCount)")
        }) { [weak self] (data) in
            let image = UIImage(data: data)
            self?.pic.image = image
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


