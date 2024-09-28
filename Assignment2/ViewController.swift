//
//  ViewController.swift
//  Assignment2
//
//  Created by Sona on 28.09.24.
//

import UIKit

class ViewController: UIViewController {
    
    var currentPage = 1
    let pageCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
    }
    
    private func getInfo(){
        if currentPage <= pageCount {
            networkCall(page: currentPage)
        }
    }
    
    private func networkCall(page: Int) {
        NetworkManager.shared.fetchUsers(page: currentPage, results: 10) {[weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let res):
                DispatchQueue.main.async {
                    self.displayUsers(res.results)
                    self.currentPage += 1
                    self.getInfo()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func displayUsers(_ users: [Result]) {
        print("\(currentPage) Page Info")
        users.forEach{
            print("iD:", $0.id.name + "," + "User FullName:", $0.name.fullName, ",User Location:", $0.location.locationInfo, "\n")
        }
    }
    
    private func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
