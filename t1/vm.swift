

import Foundation

class vm : ObservableObject {
    
    @Published var id = ""
    @Published var nicname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var password2 = ""
    
    func onClick (){
        print(id)
    }
}
