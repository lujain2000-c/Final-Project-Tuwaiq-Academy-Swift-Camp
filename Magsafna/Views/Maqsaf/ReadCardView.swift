//
//  ReadCardView.swift
//  Magsafna
//
//  Created by لجين إبراهيم الكنهل on 02/12/1444 AH.
//

import SwiftUI
import CoreNFC

struct ReadCardView: View {
    @StateObject var vm1 = ViewController()
    @StateObject var vm = DataManager()
    @State var showGG = false
  
    var body: some View {
        NavigationStack{
            VStack{
                VStack {
                    
                    Image(systemName: "wave.3.right")
                        .resizable()
                        .frame(width: 150,height: 150)
                        .padding(.bottom,150)
                    //Spacer()
                    Button("Read"){
                        vm1.CaptureBtn()
                    }.foregroundColor(Color.white)
                        .font(.custom( "Play-Regular", size: 20))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity,maxHeight: 50)
                        .background(Color("purplei"))
                        .cornerRadius(10)

                        .shadow(radius: 4)
                    
                    
                    
                    
                    Button( vm1.uid){
                        vm.fetchChildMaqsaf(childID: vm1.uid) {
                            showGG = true
                        }
                    }
                    
                    
                    
                }
            }
            .sheet(isPresented: $showGG) {
                InfoView()
                    .environmentObject(vm)
            }
                .padding()
        }
    }
  
    
  
}

struct ReadCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReadCardView()
    }
}

class ViewController: UIViewController, NFCTagReaderSessionDelegate, ObservableObject {
    
    @Published var uid = ""
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print ("Session Begun!")
    }
    
   // @IBOutlet weak var UIDLabel: UILabel!
    var session: NFCTagReaderSession?
    override func viewDidLoad () {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func CaptureBtn() {
        self.session = NFCTagReaderSession (pollingOption: .iso14443, delegate: self)
        self.session?.alertMessage = "Hold Your Phone Near the NFC Tag"
        self.session?.begin ()
    }
//    func tagReaderSessionDidBecomeActivel(_ session: NFCTagReaderSession) {
//        print ("Session Begun!")
//    }
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print ("Error with Launching Session")
    }
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("Connecting To Tag")
        if tags.count > 1{
            session.alertMessage = "More Than One Tag Detected, Please try again"
            session.invalidate()
        }
            let tag = tags.first!
            session.connect(to: tag) { (error) in
                if nil != error{
                    session.invalidate (errorMessage: "Connection Failed")
                }
                    if case let .miFare(sTag) = tag{
                        let UID = sTag.identifier.map{ String( format: "%.2hhx", $0)}.joined()
                        print("UID:", UID)
                        print(sTag.identifier)
                        session.alertMessage = "UID Captured"
                        session.invalidate ()
                            
                        DispatchQueue.main.async {
                            self.uid = UID
                        }
//                        DispatchQueue.main.async {
//                            self.UIDLabel.text = "\(UID)"
//                        }
                    }
                }
            }
        }
    

