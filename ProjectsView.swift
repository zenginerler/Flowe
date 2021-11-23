//
//  ProjectsView.swift
//  flowe
//
//  Created by Michael Walters on 11/22/21.
//

import SwiftUI

struct ProjectsView: View {
    @State var name = "Project 1"
    @State var dueDate = Date()
    @State var description = ""
    
    var body: some View {
        VStack{
            HStack{
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 25.0)
                    .padding(.leading, 40)
                Spacer()
            }
            
            HStack{
                Image(systemName: "calendar")
                    .foregroundColor(Color("color4"))
                Text("Due: \(dueDate, formatter: dateFormatter)")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.top, 10.0)
            .padding(.bottom, 28)
            .padding(.leading, 35)
//            VStack{
//                HStack{
//                    Text("")
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//                .padding()
//                Spacer()
//            }
//
//            .padding()
//            .frame(width: 350, height: 60)
//            .background(Color("color2").ignoresSafeArea(.all, edges: .all))
            Spacer()
            VStack{
                HStack{
                    Text("hey")
                    Spacer()
                }
                .padding()
                Spacer()
            }
            .padding()
            .frame(width: 400, height: 300)
            .background(Color("color2").ignoresSafeArea(.all, edges: .all))
            Spacer()
            
        }
        .background(Color(red: 0.3411764705882353, green: 0.4588235294117647, blue: 0.5647058823529412))
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    return formatter
}()

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
