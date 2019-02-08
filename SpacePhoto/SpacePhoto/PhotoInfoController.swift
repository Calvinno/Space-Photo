//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Calvin Cantin on 2019-02-06.
//  Copyright © 2019 Calvin Cantin. All rights reserved.
//

import Foundation
struct PhotoInfoController
{
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void)
    {
        let baseUrl = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let query: [String: String] =
            [
                "api_key": "DEMO_KEY",
                "date": "2003-10-07"
        ]
        let url = baseUrl.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data)
            {
                completion(photoInfo)
            }
            else
            {
                print("Either no data was returned, or data was not properly decoded")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
