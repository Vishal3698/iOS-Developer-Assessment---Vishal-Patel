//
//  SelectedListOfUsers.swift
//  Assessment
//
//  Created by Vishal Patel on 2021-09-30.
//

import SwiftUI

@available(iOS 15.0, *)
struct SelectedListOfUsersView: View {
    var selectedUserName: String
    
//  Provide the value - If user has pressed on followers or following
    var selectedButtonTitle: String

    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack{
            List(viewModel.ListOfUsers) { data in
                NavigationLink(destination: {
                    UserView(selectedUserName: data.login ?? "Hi")
                }, label: {
                    Text(data.login ?? "No Username")
                })
            }
            .refreshable {
            }
        }
        .navigationBarItems(
            trailing:
                    NavigationLink(destination: {
                        HomeScreen().navigationBarHidden(true)
                    }, label: {
                        Text("New Search")
                    })
        )
        
        .onAppear(perform: {
//    Constructing the URL
            viewModel.apiData.gitHubURL += selectedUserName + selectedButtonTitle
//    getFollowersData fetches the profiles of User's followers or following 
            viewModel.getListOfUsersData(urlString: viewModel.apiData.gitHubURL)
        })
    }
}

@available(iOS 15.0, *)
struct SelectedListOfUsers_Previews: PreviewProvider {
    static var previews: some View {
        SelectedListOfUsersView(selectedUserName: "Vinitshahdeo", selectedButtonTitle: "/following")
    }
}
