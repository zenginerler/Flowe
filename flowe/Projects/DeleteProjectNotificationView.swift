//
//  DeleteProjectNotificationView.swift
//  flowe
//
//  Created by Michael Walters on 12/4/21.
//


import SwiftUI

struct DeleteProjectNotificationView: View {
    var body: some View {
        VStack{
            HStack{
            Image(systemName: "trash.fill")
                    .foregroundColor(Color.white)
            Text("Project permanantly deleted.")
                .font(.title2)
                .fontWeight(.medium)
                .padding()
                .foregroundColor(Color.white)
            }
            .frame(width: UIScreen.main.bounds.width-20, height: 100)
            .background(Color("custom_red"))
            .cornerRadius(20)
        }
    }
}

struct DeleteProjectNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteProjectNotificationView()
    }
}
