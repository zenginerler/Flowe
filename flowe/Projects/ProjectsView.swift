//
//  ProjectsView.swift
//  flowe
//
//  Created by Michael Walters on 11/22/21.
//

import SwiftUI

struct ProjectsView: View {
    
    @State var project: Projects?
    
    var body: some View {
        VStack{
            HStack{
//                Text((project.name)!)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.leading)
//                    .padding(.leading, 25)
                Text("Project 1")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 25)
                    
                Spacer()
                // edit button
                Button(action: {
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                        
                }
                .padding(.trailing, 35)
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image(systemName: "trash.fill")
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/)
                }
                .padding(.trailing, 20)
            }
            .padding(.bottom, 45)
            
            
            // project description
            VStack{
                
                // due date
                HStack{
//                    let dueDate = dateFormatter.string(from: project!.due!)
                    Image(systemName: "calendar")
                        .foregroundColor(Color.white)
                    Text("Due: ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
//                    Text("\(dueDate)")
//                            .font(.headline)
//                            .fontWeight(.medium)
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.leading)
                    Text("\(Date())")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)

                    Spacer()
                }
                .padding(.top, 15.0)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                
                // project creator
                HStack{
                    Image(systemName: "person.fill")
                        .foregroundColor(Color.white)
                    Text("Lead: ")
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
                .padding(.bottom, 20)
                .padding(.leading, 20)
                
                //team
                HStack{
                    Image(systemName: "person.3.fill")
                        .foregroundColor(Color.white)
                    Text("Team: ")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("John Smith, and 3 more")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .padding(.top, 10.0)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                
                HStack{
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.white)
                    Text("Tasks: ")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    VStack{
                        Text("Update 1")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Update 2")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 10.0)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.white)
                    Text("Goals: ")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Breakthrough 1")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .padding(.top, 10.0)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                
                HStack{
                    Image(systemName: "book.fill")
                        .foregroundColor(Color.white)
                    Text("Description: ")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 10.0)
                .padding(.leading, 20)
                HStack{
//                    Text((project.about)!)
//                        .font(.headline)
//                        .fontWeight(.medium)
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.leading)
//                        .padding(.top, 5.0)
//                        .padding(.bottom, 15)
//                        .padding(.leading, 50)
//                        .padding(.trailing, 20)
                    Text("Loren ipsum")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 5.0)
                        .padding(.bottom, 15)
                        .padding(.leading, 52)
                    Spacer()
                        
                }
            }
            // i dont know why this says view but it builds...
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.667, saturation: 0.051, brightness: 0.158)/*@END_MENU_TOKEN@*/)
            
            .cornerRadius(/*@START_MENU_TOKEN@*/12.0/*@END_MENU_TOKEN@*/)

            Spacer()
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .background(Color("custom_blue"))
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
