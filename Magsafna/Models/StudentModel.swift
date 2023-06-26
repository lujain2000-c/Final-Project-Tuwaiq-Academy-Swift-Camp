

import Foundation
import SwiftUI

struct Student : Identifiable, Codable {
    var studentNationalId : String
    var id: String {
        studentNationalId
    }
    var studentName: String
    var studentSchoolName: String
    var studentBalance: Double
    var studentGender: String
   // var studentImage : String
}
