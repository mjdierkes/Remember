//
//  ScrapeService.swift
//  Remember
//
//  Created by Mason Dierkes on 12/2/22.
//

import Foundation
import SwiftSoup

class ImageService {
    
    func placeOrder() async {
        
        let apiKey = "ce0c2cd18d134997a67b63b0e20c4314"
        let parameters = KnowledgeRequest(query: "HarryPotter", imageInfo: ImageInfo(url: "https://books.google.com/books/content?id=Sm5AKLXKxHgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"))
        
        guard let encoded = try? JSONEncoder().encode(parameters) else {
            print("Failed to encode parameters")
            return
        }
        let url = URL(string: "https://api.bing.microsoft.com/v7.0/images/visualsearch")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Image7.self, from: data)
            print(decodedOrder)
        } catch {
            print("Checkout failed.")
        }
        
    }
    
}
struct Image7: Decodable {
    let _type: String?
    var accentColor: String?
    var contentSize: String?
    var contentUrl: String?
    var datePublished: String?
    var encodingFormat: String?
    var height: Int?
    var hostPageDisplayUrl: String?
    var hostPageUrl: String?
    var imageId: String?
    var imageInsightsToken: String?
    var name: String?
    var thumbnailUrl: String?
    var webSearchUrl: String?
    var width: Int?
}

struct Order: Codable {
    let _type: String
    let tags: [Tag]
}

struct Tag: Codable{
    let displayName: String
    let actions: [Action]
    let data: Data1?
}

struct Action: Codable {
    let actionType: String
}
struct Data1: Codable {
    let value: [Value]?
}
struct Value: Codable {
    let contentUrl: String?
}

struct KnowledgeRequest: Codable {
    let query: String
    let imageInfo: ImageInfo
}

struct ImageInfo: Codable {
    let url: String
}

@MainActor extension ImageService {
//    func postRequest() {
//        // Set the API key for the Bing Image Search API.
//        let apiKey = "ce0c2cd18d134997a67b63b0e20c4314"
//
//        // Set the URL for the Bing Image Search API endpoint.
//        let url = URL(string: "https://api.bing.microsoft.com/v7.0/images/visualsearch")!
//
//        // Set the request body for the POST request.
//        let requestBody = [
//            "knowledgeRequest": [
//                "query": "dogs",
//                "imageInfo": [
//                    "url": "https://books.google.com/books/content?id=Sm5AKLXKxHgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
//                ]
//            ]
//        ]
//        // Create the URL request.
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
//        request.httpBody = try! JSONSerialization.data(withJSONObject: requestBody)
//
//        // Send the POST request.
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print(error)
//            }
//
//            if let data = data {
//                print(data)
//            }
//            print(response)
//        }
//        task.resume()
//    }
    
    func postRequest() async throws{


        var semaphore = DispatchSemaphore (value: 0)

        let parameters = [
          [
            "key": "knowledgeRequest",
            "value": "{\"imageInfo\":{\"url\":\"https://books.google.com/books/content?id=Sm5AKLXKxHgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api\"}}",
            "type": "text"
          ]] as [[String : Any]]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        var error: Error? = nil
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = param["src"] as! String
              let fileData = try NSData(contentsOfFile:paramSrc, options:[]) as Data
              let fileContent = String(data: fileData, encoding: .utf8)!
              body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
            }
          }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://api.bing.microsoft.com/v7.0/images/visualsearch")!,timeoutInterval: Double.infinity)
        request.addValue("ce0c2cd18d134997a67b63b0e20c4314", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            do {
                let order = try JSONDecoder().decode(Image7.self, from: data)
                print(order)
            } catch {
                
            }
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

    }
}
