//
//  ContentView.swift
//  BreakingBadQuotes
//
//  Created by Anup Saud on 2024-07-17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            
            FetchView(show: Constants.bbName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }
            
            FetchView(show: Constants.bscName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bscName, systemImage: "briefcase")
                }
            FetchView(show: Constants.ecName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.ecName, systemImage: "car")
                }
    
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
