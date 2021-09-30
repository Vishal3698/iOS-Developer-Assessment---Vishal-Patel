//
//  UserView.swift
//  Assessment
//
//  Created by Vishal Patel on 2021-09-29.
//

// Screen to display GitHub User Profile

import SwiftUI

@available(iOS 15.0, *)
struct UserView: View {
//    when the view is called from any screen, provide the usernmae of the profile to fetch
    var selectedUserName: String
    @StateObject var viewModel = ViewModel()

    
    var body: some View {
        ZStack{
            VStack{
                // check if fetched user profile contains avatar url data
                if let avatar = viewModel.userData.avatar_url{
                    AsyncImage(url: URL(string: avatar)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: UIScreen.main.bounds.height*0.21, height: UIScreen.main.bounds.height*0.21)
                    .cornerRadius(9)
                }
                
                Text("\(viewModel.userData.name ?? "No Name Found")")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 3)

                HStack {
                    Text("Username: ")
                        .fontWeight(.medium)
                    Text(viewModel.userData.login ?? "No")
                }
                .font(.title3)
                .padding(.vertical, 30)

                
                // Navigation Links for Followers and Following Screens only if the count is more than 0
                HStack{
                    if (viewModel.userData.followers ?? 0) > 0{
                        
                        NavigationLink(destination: SelectedListOfUsersView(selectedUserName: viewModel.userData.login ?? "User Not Found", selectedButtonTitle: "/followers"),
                        label: {
                            Text("Followers: ").fontWeight(.medium)
                                .navigationTitle(viewModel.userData.login ?? "")
                        })

                        Text("\(viewModel.userData.followers ?? 0)").padding(.trailing)

                        NavigationLink(destination: SelectedListOfUsersView(selectedUserName: viewModel.userData.login ?? "User Not Found", selectedButtonTitle: "/following")
                        , label: {
                            Text("Following: ").fontWeight(.medium)
                                .navigationTitle(viewModel.userData.login ?? "")
                        })
                        Text("\(viewModel.userData.following ?? 0)")
                    
                    }else{
                    //if the count is 0, Simple text instead of navigation links
                        Text("Followers: ").fontWeight(.medium)
                            .navigationTitle(viewModel.userData.login ?? "")
                        Text("\(viewModel.userData.followers ?? 0)").padding(.trailing)
                        Text("Following: ").fontWeight(.medium)
                            .navigationTitle(viewModel.userData.login ?? "")
                        Text("\(viewModel.userData.following ?? 0)")
                    }
                    
                }

                Text("Description(Bio): ").fontWeight(.medium).padding(.top, 9)
                if viewModel.userData.bio?.utf16.count ?? 0 > 120{
                    Text(viewModel.userData.bio ?? "No Bio Mentioned by User")
                        .font(.system(size: 13.5))
                    .lineLimit(9)
                }else{
                    Text(viewModel.userData.bio ?? "No Bio Mentioned by User")
                    .lineLimit(9)
                }
                }
            .padding(.all, 12)
                .frame(width: UIScreen.main.bounds.width*0.89, height: UIScreen.main.bounds.height*0.69, alignment: .center)
                .background(Color.secondary.opacity(0.09)).ignoresSafeArea()
                .cornerRadius(18)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: 0)
        }
        
//      Provide New Search Button to display home screen again
        .navigationBarItems(
            trailing:
                    NavigationLink(destination: {
                        HomeScreen().navigationBarHidden(true)
                    }, label: {
                        Text("New Search")
                    })
        )
        
//        Before the view is showed on screen, Do following:
        .onAppear(perform: {
//        Set the viewmodel data to load correct profile, and then call getUserData function
            viewModel.apiData.selectedUserName = selectedUserName
            viewModel.getUserData(urlString: viewModel.apiData.selectedUserName)
        })
    }
}

@available(iOS 15.0, *)
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(selectedUserName: "Vinitshahdeo")
            .previewDevice("iPhone 8")
    }
}
