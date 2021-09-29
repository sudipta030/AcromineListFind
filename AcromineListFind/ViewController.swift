//
//  ViewController.swift
//  AcromineListFind
//
//  Created by Sudipta on 28/09/21.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var tblAcromineList: UITableView!
    @IBOutlet weak var txtAcromine: UITextField!
    private let viewmodel = AcromineViewModel()
   private let acrominelistmodel = acrominelistviewmodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        acrominelistmodel.acrominelist.bind { [weak self] _ in
            // reload the table
            DispatchQueue.main.async {
                self?.tblAcromineList.reloadData()
            }
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        txtAcromine?.resignFirstResponder()
        if viewmodel.stringValidation(str: txtAcromine?.text) {
            self.apiCall(strAcromine: txtAcromine.text!)
        }
        else {
        
            self.showalert(message: "Text should not be empty.")
            
              }
        }
     // api call
    func apiCall(strAcromine: String) {
        viewmodel.getdatafromserver(key: strAcromine) { (acrominelist: [AcromineList]?,message: String) in
                  if message == "data found"
                  {
                    self.acrominelistmodel.acrominelist.value = acrominelist?[0].lfs.compactMap({Acrominelistcellviewmodel(lf: $0.lf ?? "")})
        
                  }
                    else
                  {
                    self.showalert(message: message)
                  }
        
                }
    }
    
    // alertview controller
    func showalert(message: String) {
        let alert = UIAlertController(title: "AcromineListFind", message: message, preferredStyle: .alert)

              // add an action (button)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

              // show the alert
              self.present(alert, animated: true, completion: nil)
    }
    // textfield delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acrominelistmodel.acrominelist.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = acrominelistmodel.acrominelist.value?[indexPath.row].lf
        return cell
    }
}
