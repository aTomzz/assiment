//
//  InfoView.swift
//  InfoDay
//
//  Created by e9207182 on 21/9/2022.
//

import SwiftUI

struct InfoView: View {
    
    @AppStorage("darkMode") var darkMode: Bool = false
    @State var comment: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Image("hkbu_logo")
                .resizable()
                .frame(width: 192.0, height: 192.0)
            Text("HKBU InfoDay App")
                .fontWeight(.bold)
                .font(.title)
            List {
                Section(header: Text("Important Numbers")) {
                    ForEach(Contact.data) { contact in
                        HStack {
                            Image(systemName: "phone.fill.arrow.up.right")
                            Text(contact.office)
                            Spacer()
                            // Text(contact.tel)
                            Link(contact.tel, destination: URL(string: "tel:\(contact.tel)")!)
                        }
                    }
                }
                Section(header: Text("Settings")) {
//                    Text("Dark Mode")
//                        .onTapGesture {
//                            darkMode = true
//                        }
//                    Text("Light Mode")
//                        .onTapGesture {
//                            darkMode = false
//                        }
                    Toggle("Dark Mode", isOn: $darkMode)
                }
                Section(header: Text("Feedbacks")) {
                    TextField(
                        "Comments",
                        text: $comment
                    )
                    Button("Submit", action: {
                        submit()
                    })
                    .alert(alertTitle, isPresented: $showAlert, actions: {
                        Button("OK") {}
                    })
                }            }
            .padding(.top, 32.0)
        }
        .padding(.top, 32.0)
    }
}

extension InfoView {
    func handleClientError(_: Error) {
        return
    }
    
    func handleServerError(_: URLResponse?) {
        return
    }
    
    func submit() {
        
        let endpoint = URL(string: "https://httpbin.org/post")!
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        let postString = "Comment=\(comment)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                self.handleClientError(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                return
            }
            
            if let data = data,
               let string = String(data: data, encoding: .utf8) {
                showAlert = true
                alertTitle = string
            }
           
        }
        
        task.resume()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct Contact: Identifiable {
    var id = UUID()
    var office: String
    var tel: String
}

extension Contact {
    static let data = [
        Contact(office: "Admission Office", tel: "3411-2200"),
        Contact(office: "Emergencies", tel: "3411-7777"),
        Contact(office: "Health Services Center", tel: "3411-7447")
    ]
}
