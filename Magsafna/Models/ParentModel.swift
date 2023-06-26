


import SwiftUI

struct Parent : Identifiable, Codable {
    var parentId : String
    var id : String {
        parentId
    }
    var parentName : String
    //var parentEmail : String
    var parentPhone : String
   // var parentPassword : String
   // var parentImage : String
}
