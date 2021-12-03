//
//  NotificationView.swift
//  flowe
//
//  Created by Michael Walters on 12/3/21.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack{
            Text("Project Completed!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(Color.white)
            Text("You can still view this project in 'Project Archive'")
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
                .foregroundColor(Color.white)
        }
        .frame(width: UIScreen.main.bounds.width-20, height: 180)
        .background(Color(red: 0.9607843137254902, green: 0.6431372549019608, blue: 0.1450980392156863))
        .cornerRadius(20)
    }
    
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
