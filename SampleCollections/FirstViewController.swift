//
//  FirstViewController.swift
//  SampleCollections
//
//  Created by 丸山 三喜也 on 2020/05/10.
//  Copyright © 2020 丸山 三喜也. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var listTable: UITableView!
    
    var sampleList: [[String:String]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "first view"
        listTable.delegate = self
        listTable.dataSource = self
        viewSetup()
    }
    
    func viewSetup() {
        sampleList = [
            [
                "title": "Collection",
                "file": "CollectionViewController",
            ],
            [
                "title": "AudioPlayer",
                "file": "AudioPlayerViewControoler",
            ],
            [
                "title": "Third",
                "file": "ThirdViewController",
            ],
        ]
    }
    
    func showAlert() {
        let alert = UIAlertController.init(title: "アラート", message: "No available view controller", preferredStyle: .alert)
        let actionOk = UIAlertAction.init(title: "OK", style: .default, handler: {(act: UIAlertAction) -> Void in
            print("OK")
        })
        let actionCancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: {(act: UIAlertAction) -> Void in
            print("Cancel")
        })
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "List")
        cell.textLabel?.text = sampleList[indexPath.row]["title"]
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dump(sampleList[indexPath.row])
        let detail: [String:String] = sampleList[indexPath.row]
        
        guard let fname = detail["file"],
            let _ = Bundle.main.path(forResource: fname, ofType:"storyboard"),
            let _ = Bundle.main.path(forResource: fname, ofType:"swift")else {
            showAlert()
            return
        }
        
        let storyboard = UIStoryboard.init(name: fname, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: fname)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
