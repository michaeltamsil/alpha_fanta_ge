//
//  ContentView.swift
//  alpha_fanta_ge
//
//  Created by michael tamsil on 20/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            TabView {
                FirstScreenView()
                    .tabItem({
                        Text("First")
                    })
                    .tag(0)
                
                SecondScreenView()
                    .tabItem({
                        Text("Second")
                    })
                    .tag(1)
                
                ThirdScreenView()
                    .tabItem({
                        Text("Third")
                    })
                    .tag(2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
