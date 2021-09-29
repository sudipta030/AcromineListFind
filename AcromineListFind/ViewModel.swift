//
//  ViewModel.swift
//  APICODENEWWAY
//
//  Created by Sudipta on 12/05/21.
//

import Foundation
class AcromineViewModel {
    func stringValidation(str: String?) -> Bool {
        if let strAcromine = str, !(strAcromine.isEmpty) {
            return true
        }
        else {
           return false
        }
    }
    
    func getdatafromserver(key:String, completion:@escaping(([AcromineList]?,String)->()))
      {
        let apiurl = URL(string: baseurl + key)
        URLSession.shared.dataTask(with: apiurl!) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil,err.localizedDescription)
            }
            else
            {
                guard let responsedata = data else {
                    return
                }
                do
                {
                    let response = try JSONDecoder().decode([AcromineList].self, from: responsedata)
                    completion(response,"data found")
                }
                catch let jsonerror {
                    completion(nil,jsonerror.localizedDescription)
                }
            }
        }.resume()
    }
}

class obserable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T?) {
        self.value = value
    }
    var listener: ((T?) -> Void)?
    func bind(_ listener: @escaping(T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
struct acrominelistviewmodel {
    var acrominelist:  obserable<[Acrominelistcellviewmodel]> = obserable([])
}
struct Acrominelistcellviewmodel {
    var  lf: String
}

