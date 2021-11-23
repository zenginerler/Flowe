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
                    .foregroundColor(Color.white)
                Text("Due: ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("\(dueDate, formatter: dateFormatter)")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.top, 20.0)
            .padding(.bottom, 28)
            .padding(.leading, 30)
            
            HStack{
                Image(systemName: "person")
                    .foregroundColor(Color.white)
                Text("Project Lead: ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("John Smith")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.top, 10.0)
            .padding(.bottom, 28)
            .padding(.leading, 30)
            
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
