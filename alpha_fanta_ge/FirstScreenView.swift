//
//  FirstScreenView.swift
//  alpha_fanta_ge
//
//  Created by michael tamsil on 20/12/20.
//

//    https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo
//    First screen should allow user to enter “symbol” to search its Intraday data. (show only
//    open, high, low and date/time)

import Combine
import SwiftUI
import UIKit

struct FirstScreenView: View {
    
    @State var search: String = ""

    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor.gray))
                TextField("Search", text: $search, onEditingChanged: { changed in
                    if (!changed){
                        guard let url = URL(string:"https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(search)&interval=5min&apikey=NU4Z0XAAWDABL0RI") else { return }
                        URLSession.shared.dataTask(with: url) { ( data, response, error ) in
                            guard let data = data else { return }
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                    
                                    let newResults = json["Time Series (5min)"] as! [[String: Any]]
                                    print(newResults)
                                }
                            } catch let error as NSError {
                                print("Failed to load: \(error.localizedDescription)")
                            }
                            
                        }
//                        guard let data = data else { return }
                    }
                })
                    .foregroundColor(Color(UIColor.gray))
            }
            .foregroundColor(Color(UIColor.systemGray))
            .padding(10)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            ScrollView {
                Text("Header")
                List {
                    
                }
            }
            
            Spacer()
        }
        .padding(.vertical)
        
        
    }
}

struct FirstScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreenView()
    }
}
