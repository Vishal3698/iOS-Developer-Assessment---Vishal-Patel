//
//  UserHelpView.swift
//  Assessment
//
//  Created by Vishal Patel on 2021-09-29.

//  User Help Screen to guide user how to use application

import SwiftUI

struct UserHelpView: View{
    var body: some View {
        VStack{
            Text("To Search Github Profiles:")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack{
                HStack{
                Text("1. ")
                    .foregroundColor(.secondary)
                    .frame(width: 21, height: 60, alignment: .top)
                Text("Enter exact username of the GitHub profile you want to search in the searchbar (Do not add spaces)")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            
                HStack{
                Text("2. ")
                    .foregroundColor(.secondary)
                    .frame(width: 21, height: 10, alignment: .center)
                Text("Press Search on the keyboard to search")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(.top)

                HStack{
                Text("3. ")
                    .foregroundColor(.secondary)
                    .frame(width: 21, height: 60, alignment: .top)
                Text("If followers or Following count is more than 0, You can click on the linnk to see User's followers/following")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top)
                
                HStack{
                Text("4. ")
                    .foregroundColor(.secondary)
                    .frame(width: 21, height: 10, alignment: .center)
                Text("Press cancel on the seachbar to abort")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top)
            }
            .padding()
            
        }
        
    }
    
}


struct UserHelpView_Previews: PreviewProvider {
    static var previews: some View {
        UserHelpView()
            .previewDevice("iPhone 8")
    }
}
