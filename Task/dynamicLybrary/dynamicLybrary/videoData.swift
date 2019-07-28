//
//  videoData.swift
//  dynamicLybrary
//
//  Created by Mac on 28/07/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation


public class videoData
{
    public let name : String
    
    public init(name : String)
    {
        self.name = name
    }
    // We can pass API Key in funcation call.
    public func getAPIData(onSuccess success: @escaping (_ JSON: [String:Any]) -> Void, onFailure failure: @escaping (_ error: Error?, _ params: String) -> Void) {
        

        
        let urlPath = "https://api.themoviedb.org/3/list/1?api_key=ba9849e3c344e0a1c9f276d0e8226448&language=en-US"
        print(urlPath)
        
        guard let url = URL(string: urlPath) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                failure(error, "Server error")
                return
                
            }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                    //    print(results)
                    
                     success(jsonResult)
                }
                else
                {
                    failure(error, "Server error")
                }
            } catch {
                //Catch Error here...
            }
        }
        task.resume()
        
    }

}


