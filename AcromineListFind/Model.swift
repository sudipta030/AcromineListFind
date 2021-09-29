//
//  Model.swift

//

import Foundation

struct AcromineList: Decodable {
    let lfs: [Acromine]
}
struct Acromine: Decodable {
    let lf : String?
  
    
}

