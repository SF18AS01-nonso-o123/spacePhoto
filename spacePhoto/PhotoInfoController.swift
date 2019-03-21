//
//  PhotoInfoController.swift
//  spacePhoto
//
//  Created by Chinonso Obidike on 3/19/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import Foundation
struct PhotoInfoController {
func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
    guard let baseURL = URL(string: "https://api.nasa.gov/planetary/apod") else {
        print("clould not print baseURL")
        completion(nil)
        return
    }
    let query: [String: String] = ["api_key": "DEMO_KEY"]
       
    guard let url = baseURL.withQueries(query) else {
        print("could not create url")
        completion(nil)
        return
    }
    let task = URLSession.shared.dataTask(with: url)
    {(data: Data?, response: URLResponse?, error: Error?) in
        let jsonDecoder = JSONDecoder()
            guard let data = data else {
                print("cannot download data")
                completion(nil)
                return
            }
            guard let string = String(data: data, encoding: .utf8) else {
                print("cannot convert data")
                completion(nil)
                return
            }
            print(string)
           guard let photoInfo = try?
               jsonDecoder.decode(PhotoInfo.self, from: data) else {
            print("data was not serialized")
            completion(nil)
                return
        }
            completion(photoInfo)
    }
    task.resume()
}
}
