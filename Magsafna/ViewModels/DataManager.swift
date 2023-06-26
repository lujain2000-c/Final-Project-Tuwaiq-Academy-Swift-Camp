//
//  DataManager.swift
//  GP-OnboardingSign
//
//  Created by لجين إبراهيم الكنهل on 28/11/1444 AH.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class DataManager: ObservableObject {
    
    @Published var cards: [Card] = [Card (name: "¡Justine", cardNumber: number.randomElement()! , cardColor: colors.randomElement()!)]
    
    @Published var child = Student(studentNationalId: "", studentName: "", studentSchoolName: "", studentBalance: 0.0, studentGender: "F")
    @Published var childM = Student(studentNationalId: "", studentName: "", studentSchoolName: "", studentBalance: 0.0, studentGender: "F")
    @Published var parent = Parent(parentId: "", parentName: "", parentPhone: "")
    @Published var school = School(schoolId: "", schoolName: "", schoolPhone: "", schoolPayment: "")
    
    @Published var payment = ""
    @Published var userType = "parent"
    @Published var signOut = false
    
    
    
    let db = Firestore.firestore()
    func addParent(fullName: String, phoneNumber: String){  //تم
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("parent").document(user?.email ?? "").setData([
                    "full_name" : fullName,
                    "phone_number" : phoneNumber
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    func addChild(childID: String, childName: String, childSchool: String, childGender: String){ //تم
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("parent").document(user?.email ?? "").collection("child").document(childID).setData([
                    "child_name" :  childName,
                    "child_school" : childSchool,
                    "child_id": childID,
                    "child_balance": 0.0,
                    "child_gender": childGender
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
            self.fetchAllChild()
        }
        
    }
    
    
    func fetchParent(){ // تم
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("parent").document(user?.email ?? "").getDocument{ (document, error) in
                    if let document = document, document.exists {
                        
                        let fullName = document.get("full_name") as! String
                        let phoneNumber = document.get("phone_number") as! String
                     
                        
                    
                        self.parent = Parent(parentId: user?.email ?? "", parentName: fullName, parentPhone: phoneNumber)
//                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                        print("Document data: \(dataDescription)")
                    } else {
                        print("Document does not exist")
                    }
                }
                
            }
        }
    }
    
    
    func fetchAllChild(){ // تم
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("parent").document(user?.email ?? "").collection("child").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var cards1: [Card] = []
                        for doc in querySnapshot!.documents{
                            let data = doc.data()
                            let childrenName = data["child_name"] as! String
                            let childrenID = data["child_id"] as! String
                            let card = Card(name: childrenName, cardNumber: childrenID, cardColor: colors.randomElement()!)
                            cards1.append(card)
                            
                        }
                        self.cards = cards1
                        
                    }
                }
            }
        }
        
      
    }
    func fetchChild(childName: String){ //تم
        
        // Specify the field and value to query
                let fieldName = "child_name"
                let fieldValue = childName

                // Query the documents based on the condition
                Auth.auth().addStateDidChangeListener { auth, user in
                    if Auth.auth().currentUser != nil {
                     self.db.collection("parent").document(user?.email ?? "").collection("child")
                    .whereField(fieldName, isEqualTo: fieldValue) // 👀🦜🤖
                    .getDocuments { (querySnapshot, error) in // Step 1: you Need to get the document(s) you want to update
                    if let error = error {
                        print("Error getting documents: (error)")
                    } else {
                        guard let documents = querySnapshot?.documents else {
                            print("No matching documents.")
                            return
                        }

                        // Iterate over the matching documents and update them
                        for document in documents {
                            let data = document.data()
                            let childName = data["child_name"] as! String
                            let childID = data["child_id"] as! String
                            let childSchoolName = data["child_school"] as! String
                            let childBalance = data["child_balance"] as! Double
                            let childGender = data["child_gender"] as! String
                            self.child = Student(studentNationalId: childID , studentName: childName, studentSchoolName: childSchoolName, studentBalance: childBalance, studentGender: childGender)
                           

                        }
                    }
                }
    

                        self.fetchMaqsafLink(schoolName: self.child.studentSchoolName)
                    }
//                    self.fetchMaqsafLink(schoolName: self.child.studentSchoolName)
       }
        
        
    }
    
    
    // MARK: - Update Docuement With Generated ID
    
    func updateParent(newFullName: String, newPhoneNumber: String){ // تم
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("parent").document(user?.email ?? "").setData([
                    "full_name" : newFullName,
                    "phone_number" : newPhoneNumber
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
           
            self.fetchParent()
        }
        
    }
    
    func updateChild( ChildID: String, newChildName: String, newChildSchool: String, newChildBalanse: Double, gender: String){
        
        
        // Create a data dictionary with the field you want to update
        let updatedData: [String: Any] = [
            "child_name" : newChildName,
            "child_school" : newChildSchool,
            "child_balance" : newChildBalanse,
            "child_gender" : gender
            //"child_id": childNewID
        ]
        
        // Query the documents based on the condition
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("parent").document(user?.email ?? "").collection("child")
                    .document(ChildID).setData(updatedData, merge: true) { error in
                        if let error = error {
                            print("Error updating document: \(error)")
                        } else {
                            print("Document updated successfully")
                        }
                    }
                self.fetchChild(childName: newChildName)

            }
        }
    }
    
    func deleteChild(childID: String){
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("parent").document(user?.email ?? "").collection("child").document( childID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }
        }
    }
    
    
    
    func addMaqsaf(schoolName: String, phoneNumber: String, paymentLink: String = ""){
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("school").document(user?.email ?? "").setData([
                    "school_name" : schoolName,
                    "school_phone" : phoneNumber,
                    "payment_link" : paymentLink
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    func fetchMaqsaf(){
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("school").document(user?.email ?? "").getDocument{ (document, error) in
                    if let document = document, document.exists {
                        
                        let schoolName = document.get("school_name") as! String
                        let schoolPhone = document.get("school_phone") as! String
                        let schoolPayment = document.get("payment_link") as! String
                    
                        self.school = School(schoolId: user?.email ?? "", schoolName: schoolName, schoolPhone: schoolPhone, schoolPayment: schoolPayment)
                    } else {
                        print("Document does not exist")
                    }
                }
                
            }
        }
    }
    
  
    
    
    func updateMaqsaf(schoolName: String, phoneNumber: String, paymentLink: String){
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("parent").document(user?.email ?? "").setData([
                    "school_name" : schoolName,
                    "phone_number" : phoneNumber,
                    "payment_link": paymentLink
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                self.fetchMaqsaf()
            }
            
        }
    }
    
    
    
    func fetchChildMaqsaf(childID: String, completion: @escaping () -> Void){
        // Specify the field and value to query
        let fieldName = "child_id"
        let fieldValue = childID
        print(childID)
        
        // Query the documents based on the condition
      
        self.db.collectionGroup("child").whereField(fieldName, isEqualTo: fieldValue) // 👀🦜🤖
            .getDocuments { (querySnapshot, error) in // Step 1: you Need to get the document(s) you want to update
                print("gggggggg1")

                if let error = error {
                    print("Error getting documents: (\(error)")
                    print("gggggggg2")

                } else {
                    print("gggggggg3")

                    guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                        print("No matching documents.")
                        return
                    }
                    
                    
                    // Iterate over the matching documents and update them
                    for document in documents {
                        let data = document.data()
                        let childName = data["child_name"] as! String
                        let childID = data["child_id"] as! String
                        let childSchoolName = data["child_school"] as! String
                        let childBalance = data["child_balance"] as! Double
                        let childGender = data["child_gender"] as! String
                        self.childM = Student(studentNationalId: childID , studentName: childName, studentSchoolName: childSchoolName, studentBalance: childBalance, studentGender: childGender)
                        completion()
                        
                        
                    }
                }
            }
    }
    
    
    func fetchMaqsafLink(schoolName: String){
        
        // Specify the field and value to query
        let fieldName = "school_name"
        let fieldValue = schoolName
        
        // Query the documents based on the condition
        self.db.collection("school").whereField(fieldName, isEqualTo: fieldValue) // 👀🦜🤖
            .getDocuments { (querySnapshot, error) in // Step 1: you Need to get the document(s) you want to update
                if let error = error {
                    print("Error getting documents: (error)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                        print("No matching documents.")
                        return
                    }
                    
                    // Iterate over the matching documents and update them
                    for document in documents {
                        let data = document.data()
                        let paymentLink = data["payment_link"] as! String
                      
                        self.payment = paymentLink
                        
                        
                    }
                }
            }
        
       
       
    }
    
    
    
    func addAllusers( email: String){
        
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser != nil {
                self.db.collection("privilege").document(user?.email ?? "").setData([
                    "user_type" : "parent",
                    "email" : email
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
        
    }
    
    
    func fetchUserType(){ //تم
        
        // Specify the field and value to query
                let fieldName = "email"
                //let fieldValue = email

                // Query the documents based on the condition
                Auth.auth().addStateDidChangeListener { auth, user in
                    if Auth.auth().currentUser != nil {
                        self.db.collection("privilege").whereField(fieldName, isEqualTo: user?.email ?? "") // 👀🦜🤖
                    .getDocuments { (querySnapshot, error) in // Step 1: you Need to get the document(s) you want to update
                        print("gggggggg1")
                    if let error = error {
                        print("Error getting documents: (error)")
                    } else {
                        print("gggggggg3")
                        guard let documents = querySnapshot?.documents else {
                            
                            print("No matching documents.")
                            return
                        }

                        // Iterate over the matching documents and update them
                        for document in documents {
                            let data = document.data()
                            let userTypes = data["user_type"] as! String
                          
                            self.userType = userTypes
                          
                            print(userTypes)
                        }
                    }
                }

                        
                    }
//                    self.fetchMaqsafLink(schoolName: self.child.studentSchoolName)
       }
        
        
    }
    
    func signOutUser(){
       
        Auth.auth().addStateDidChangeListener { auth, user in
            if Auth.auth().currentUser == nil {
                self.signOut = true
            }
          
        }
    }
    
}

