


import SwiftUI

struct School : Identifiable, Codable {
    var schoolId : String
    var id : String {
        schoolId
    }
    var schoolName : String
    var schoolPhone : String
    //var schoolEmail : String
    //var schoolPassword : String
    //var schoolImage : String
    var schoolPayment: String
}
