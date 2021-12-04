//
//  ProjectsView.swift
//  flowe
//
//  Created by Michael Walters on 11/22/21.
//

import SwiftUI
import UIKit
import Lottie

struct ProjectsView: View {
    
    @State var project: Projects?
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingAlert = false
    @State var lightMode = Color(hue: 0.618, saturation: 0.546, brightness: 0.702)
    @State var darkMode = Color(hue: 0.618, saturation: 0.546, brightness: 0.702)
    
    @State var reminderTapped = false
    @State var calendarTapped = false
    @State private var completeTapped: Bool = false
    
    var body: some View {
        // begin main vstack
        VStack{
            HStack{
                Text((project!.name)!)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 25)
                Spacer()
                Spacer()
                // edit button
                // delete button
            }
            .padding(.bottom, 45)
            .padding(.top, 40)

            // project details
            VStack{
                // due date
                HStack{
                    let dueDate = dateFormatter.string(from: project!.due!)
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                    Text("Due: ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text("\(dueDate)")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.top, 15.0)
                .padding(.bottom, 20)
                .padding(.leading, 20)

                HStack{
                    Image(systemName: "book.fill")
                        .foregroundColor(.black)
                    Text("Description: ")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top, 10.0)
                .padding(.leading, 20)
                HStack{
                    Text((project!.about)!)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 5.0)
                        .padding(.bottom, 15)
                        .padding(.leading, 52)
                    Spacer()
                }
            }
            // i dont know why this says view but it builds...
            .background(Color("custom_logo_light_blues"))
            .cornerRadius(12.0)
            Spacer()
            Button (action: {
                self.reminderTapped.toggle()
            }, label: {
                Text("Add Reminder")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color("custom_gray"))
                    .cornerRadius(15)
            }).padding(.top)
            
            Button (action: {
                self.calendarTapped = true
            }, label: {
                Text("Add to Calendar")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color("custom_gray"))
                    .cornerRadius(15)
            }).padding(.top)
            
            Button (action: {
                withAnimation{
                    self.completeTapped = true
                    do{
                        project?.finished = true
                        try managedObjectContext.save()
                    }
                    catch{
                        
                    }
                }
//                Variables.removeProject = true
                
            }, label: {
                Text("Mark as Complete")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color("custom_green"))
                    .cornerRadius(15)
            }).padding(.top)
            if completeTapped {
                NotificationView()
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                            withAnimation(.default) {
                                self.completeTapped.toggle()
                            }
                        }
                    }
                    .offset(y: -UIScreen.main.bounds.height/6)
                    .transition(.asymmetric(insertion: .scale, removal: .slide))
            }
            Spacer()
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .background(Color("custom_logo_blues"))
        .fullScreenCover(isPresented: $reminderTapped) {
            // Custom Page Segue from SwiftUI to UIkit
            SegueSwiftUI(storyboard: "Main", VC: "SegueVC").ignoresSafeArea(.all)
        }
        .fullScreenCover(isPresented: $calendarTapped) {
            // Custom Page Segue from SwiftUI to UIkit
            SegueSwiftUI(storyboard: "Main", VC: "SegueVC").ignoresSafeArea(.all)
        }
         //end test vstack - comment at this line
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
