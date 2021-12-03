//
//  NotificationView.swift
//  flowe
//
//  Created by Michael Walters on 12/3/21.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        HStack{
            Text("Project Completed!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(Color.white)
                .frame(width: UIScreen.main.bounds.width-20, height: 100)
                .background(Color(red: 0.9607843137254902, green: 0.6431372549019608, blue: 0.1450980392156863))
                .cornerRadius(20)
        }
    }
    
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
