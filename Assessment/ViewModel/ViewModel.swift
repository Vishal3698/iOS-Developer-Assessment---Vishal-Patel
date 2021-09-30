//
//  ViewModel.swift
//  Assessment
//
//  Created by Vishal Patel on 2021-09-29.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var apiData = APIData()
    @Published var userData = UserProfile(id: 0, avatar_url: nil, login: nil, followers: 0, following: 0, name: nil, bio: nil)
    @Published var ListOfUsers = [UserProfile]()
    
//    If URL fetch no data, toggle the value to true
    @Published var invalidURL: Bool = false
    
    
    func getUserData(urlString: String){
        let apiRequestURL = "https://api.github.com/users/" + urlString
        let url = URL(string: apiRequestURL)
        
//        Nil the user profile data before fetching new data
        userData = UserProfile(id: 0, avatar_url: nil, login: nil, followers: nil, following: nil, name: nil, bio: nil)
        
//        check if URL returns any data
            if let myUrl = url{
                // Token to access API data
                let token = apiData.searchToken
                var request = URLRequest(url: myUrl)
                request.httpMethod = "POST"
                request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
                
                
                URLSession.shared.dataTask(with: myUrl) {data, response, error in
                    DispatchQueue.main.async {
                        if let userData = data {
                            do{
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(UserProfile.self, from: userData)
                                DispatchQueue.main.async {
                                    self.userData = decodedData
                                }
                            }catch{
                                print(error.localizedDescription)
                            }
                        }
                    }
                }.resume()
            }else{
//    If URL fetch no data, toggle the value to true
                invalidURL = true
            }
    }
    
    
    
    func getListOfUsersData(urlString: String){
        let url = URL(string: urlString)
        
        if let myUrl = url{
            let token = apiData.searchToken
            var request = URLRequest(url: myUrl)
            request.httpMethod = "POST"
            request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            
            URLSession.shared.dataTask(with: myUrl) {data, response, error in
                DispatchQueue.main.async {
                    if let userData = data {
                        do{
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([UserProfile].self, from: userData)
                            DispatchQueue.main.async {
                                self.ListOfUsers = decodedData
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    }
                }
            }.resume()
        }
    }
    
}
