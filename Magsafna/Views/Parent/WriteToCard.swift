//
//  WriteToCard.swift
//  Magsafna
//
//  Created by لجين إبراهيم الكنهل on 02/12/1444 AH.
//

import SwiftUI
import CoreNFC

struct WriteToCard: View {
    @State var urlT = ""
        @State var writer = NFCReader()
    @State var nationalId : String = ""
        var body: some View {
  
            VStack {
                Text("Card Information")
                    .font(.custom( "Play-Regular", size: 28))
                    .bold()
                    .padding(.bottom,50)
                    .foregroundColor(Color("purplei"))
                
                VStack(alignment: .leading) {
                    Text("Child Profile")
                        .font(.custom( "Play-Regular", size: 22))
                        .fontWeight(.semibold)
                    
                    
                    TextField("Enter URL profile", text:$urlT)
                        .autocapitalization(.none)
                        .padding()
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .shadow(radius: 0.7)
                        .padding(.bottom)
                    Text("National ID")
                        .font(.custom( "Play-Regular", size: 22))
                        .fontWeight(.semibold)
                    
                    TextField("Enter the child national Id", text:$nationalId)
                        .autocapitalization(.none)
                        .padding()
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(5.0)
                        .shadow(radius: 0.7)
                        .padding(.bottom,56)
                }
                
                Spacer()
                
                Button(action:{
                    writer.scan(theactualdata: urlT)
                }) {
                    
                    Text("Write to Card")
                    
                    
                }  .foregroundColor(Color.primary)
                    .font(.custom( "Play-Regular", size: 20))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity,maxHeight: 50)
                    .background(Color("purplei"))
                    .cornerRadius(10)

                    .shadow(radius: 4)
                   
            }.padding(.horizontal,24)
                .padding(.vertical,120)
                
            
        }
}

struct WriteToCard_Previews: PreviewProvider {
    static var previews: some View {
        WriteToCard()
    }
}

 class NFCReader: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {

    var theactualData = ""
    var nfcSession: NFCNDEFReaderSession?

    func scan(theactualdata: String) {
        theactualData = theactualdata
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Hold Your iPhone Near an NFC Card"
        nfcSession?.begin()
    }

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) { }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) { }

    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        let str: String = theactualData
        if tags.count > 1{
            let retryInterval = DispatchTimeInterval.milliseconds(500)
            session.alertMessage = "More than one Tag Detected, please try again."
            DispatchQueue.global().asyncAfter(deadline: .now() + retryInterval, execute: {

            })
            return
        }
        let tag = tags.first!
                session.connect(to: tag, completionHandler: { (error: Error?) in
                    if nil != error {
                        session.alertMessage = "Unable to connect to tag."
                        session.invalidate()
                        return
                    }

                    tag.queryNDEFStatus(completionHandler: { (ndefStatus: NFCNDEFStatus, capacity: Int, error: Error?) in
                        guard error == nil else {
                            session.alertMessage = "Unable to query the NDEF status of tag."
                            session.invalidate()
                            return
                        }

                        switch ndefStatus {
                        case .notSupported:
                            session.alertMessage = "Tag is not NDEF compliant."
                            session.invalidate()
                        case .readOnly:
                            session.alertMessage = "Tag is read only."
                            session.invalidate()
                        case .readWrite:
                            tag.writeNDEF(.init(records: [NFCNDEFPayload.wellKnownTypeURIPayload(string: "\(str)")!]), completionHandler: {(error: Error?) in
                                if nil != error {
                                    session.alertMessage = "Write NDEF message fail: \(error!)"
                                } else {
                                    session.alertMessage = "Write NDEF message successful."
                                }
                                session.invalidate()
                            })
                        @unknown default:
                                            session.alertMessage = "Unknown NDEF tag status."
                                            session.invalidate()
                                        }
                                    })
                                })
                            }
                        }
