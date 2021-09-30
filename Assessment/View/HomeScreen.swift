//
//  HomeScreen.swift
//  Assessment
//
//  Created by Vishal Patel on 2021-09-29.
// Main Screen of the Application

import SwiftUI
import UIKit

@available(iOS 15.0, *)
struct HomeScreen: View {
    @Environment(\.dismissSearch) var dismissSearch
    
    @State private var searchBarText = ""
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    if viewModel.apiData.selectedUserName.isEmpty{
                    // Display Help to User till he searches a proile for the first time by pressing search button on keyboard
                        UserHelpView()
                            .padding(.top, 60)
                            .padding(.horizontal)
                        Spacer()
                        
                    }else{
                    // If User has entered something through search bar then check if data is fecthed from the API
                        if viewModel.userData.login != nil{
                    // If data is found, display user profile screen
                        UserView(selectedUserName: viewModel.apiData.selectedUserName)
                            
                        }else if viewModel.userData.login == nil && viewModel.invalidURL == true{
                            // If there is no data, and also the wrongURL is set to true, Display No user foound screen
                            Text("No User Profile Found \nTry Again!")
                        }else{
                            // Untill the time data is fetched display progressview
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("GitHub Profiles")
            
        }
//        Searchable provides searchbar - iOS 15 feature
        .searchable(text: $searchBarText, prompt: "Enter Username")
        .onSubmit(of: .search){
            viewModel.invalidURL = false
            viewModel.apiData.selectedUserName = searchBarText
            dismissSearch()
            DispatchQueue.main.async {
                viewModel.getUserData(urlString: viewModel.apiData.selectedUserName)
            }
        }

    }
    
}


@available(iOS 15.0, *)
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .previewDevice("iPhone X")
        HomeScreen()
            .previewDevice("iPhone 8")
            .preferredColorScheme(.dark)
    }
}


