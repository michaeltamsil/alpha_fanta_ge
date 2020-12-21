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
import Alamofire

struct FirstScreenView: View {
    
    @State var search: String = "IBM"
    @State var result: [StockTimeSeriesModel] = []

    
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
                                    
                                    let newResults = json["Time Series (5min)"] as! [String: Any]
//                                    self.result = newResults
                                    
                                    self.result = newResults.map{ item in
                                        let stockTimeSeriesModel = StockTimeSeriesModel()
                                        
                                        stockTimeSeriesModel.dateTime = item.key
                                        
                                        let value = item.value as! Dictionary<String, Any>
                                        
                                        stockTimeSeriesModel.open = Float(value["1. open"] as! String)!
                                        stockTimeSeriesModel.high = Float(value["2. high"] as!  String)!
                                        stockTimeSeriesModel.low = Float(value["3. low"] as!  String)!
                                        return stockTimeSeriesModel
                                        
//                                        debugPrint(value)
//                                        let val = item.value as! [String]
//                                        debugPrint(val)
//                                        var value = item.value
//                                        value.iterateThroughAllKeyValues { (key, value) in
//                                            debugPrint(" name \(key)")
//                                        }
                                        
                                        
//                                        debugPrint(item.value)
                                    }
//                                    print(newResults)
                                }
                            } catch let error as NSError {
                                print("Failed to load: \(error.localizedDescription)")
                            }
                            
                        }.resume()
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
            
            HStack{
                Text("Open")
                    .frame(maxWidth: .infinity)
                Text("High")
                    .frame(maxWidth: .infinity)
                Text("Low")
                    .frame(maxWidth: .infinity)
                Text("Date Time")
                    .frame(maxWidth: .infinity)
            }
            ScrollView {
                
                
//                List(self.result, id: \.self) { value in
                List {
                    ForEach(0...self.result.count, id: \.self){ item in
                        Text("test show")
//                        HStack{
//                            Text("value")
//                                .frame(maxWidth: .infinity)
//                            Text("High")
//                                .frame(maxWidth: .infinity)
//                            Text("Low")
//                                .frame(maxWidth: .infinity)
//                            Text("Date Time")
//                                .frame(maxWidth: .infinity)
//                        }

                    }
                }
            }.padding(.top)
            .padding(.horizontal)
            
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
