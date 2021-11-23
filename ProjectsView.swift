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
                    .padding(.leading, 35)
                Spacer()
            }
            .padding(.bottom, 40)
            VStack{
                HStack{
                    Image(systemName: "calendar")
                        .foregroundColor(Color.white)
                    Text("Due: ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    VStack{
                        Text("\(dueDate, formatter: dateFormatter)")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        
                        HStack{
                            Text("9 days away")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                    .padding(.top, 22.0)

                    Spacer()
                }
                .padding(.top, 20.0)
                .padding(.bottom, 10)
                .padding(.leading, 20)
                
                HStack{
                    Image(systemName: "person.fill")
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
                .padding(.bottom, 10)
                .padding(.leading, 20)
                
                HStack{
                    Image(systemName: "person.3.fill")
                        .foregroundColor(Color.white)
                    Text("Team: ")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("John Smith, Katie Perry and 3 more")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.top, 10.0)
                .padding(.bottom, 5)
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
                .padding(.bottom, 5)
                .padding(.leading, 20)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 5.0)
                    .padding(.bottom, 15)
                    .padding(.leading, 50)
                    .padding(.trailing, 20)
            }
            // i dont know why this says view but it builds...
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.728, saturation: 0.001, brightness: 0.242, opacity: 0.952)/*@END_MENU_TOKEN@*/)

            Spacer()
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .background(Color(hue: 0.052, saturation: 0.673, brightness: 0.869))
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
