//
//  DeptView.swift
//  InfoDay
//
//  Created by e9207182 on 21/9/2022.
//

import SwiftUI

struct DeptView: View {
    var body: some View {
        NavigationView{
            List(Dept.data) { dept in
                HStack {
                    NavigationLink(destination: EventView(dept_id: dept.id)) {
                        Image(dept.logo)
                            .resizable()
                            .frame(width: 48.0, height: 48.0)
                        Text(dept.title)
                    }
                }
            }
            .navigationTitle("Departments")
        }
    }
}

struct DeptView_Previews: PreviewProvider {
    static var previews: some View {
        DeptView()
    }
}

struct Dept: Identifiable {
    let id: String
    let title: String
    let logo: String
}
extension Dept {
    
    static let data: [Dept] = [
        Dept(id: "comp", title: "Computer Science", logo: "comp_logo"),
        Dept(id: "coms", title: "Communication Studies", logo: "coms_logo")
    ]
}
