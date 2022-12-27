//
//  BookService.swift
//  Remember
//
//  Created by Mason Dierkes on 12/2/22.
//

import Foundation

/// Provides an easy way to interact with the API.
class BookService {
    private let store: BookServiceStore
    private(set) var isFetching = false
    
    public init() {
        store = BookServiceStore()
    }
}

@MainActor extension BookService {
    /// Returns the decoded value of the type provided.
    /// To implement set your variable to the value that fetch data returns.
    /// Make sure to pass in the correct root or this function will throw an error.
    func fetchData<T>(from root: AvailableRoot, value: String) async throws -> T where T: Decodable {
        isFetching = true
        defer { isFetching = false }
        let loadedPackage: T = try await store.load(with: root, value: value)
        return loadedPackage
    }
}


/// Holds the credentials of the user to send up to the server.
private actor BookServiceStore {
    
    private var path = ""
    
    private var url: String {
        urlComponents.url!.absoluteString.removingPercentEncoding!
    }
    
    /// Builds a URL to connect to the API sever.
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = path
        return components
    }
    
    /// Attempts to decode the data returned from the server.
    func load<T>(with root: AvailableRoot, value: String) async throws -> T where T: Decodable {
        
        self.path = getPath()
        print(url)

        let (data, response) = try await URLSession.shared.data(from: URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw DownloadError.statusNotOK }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error \(error)")
            throw DownloadError.decoderError
        }
        
        func getPath() -> String {
            return root.rawValue + value
        }
        
    }
}

/// All the available roots on the server.
enum AvailableRoot: String {
    case bookSearch = "/books/v1/volumes?q="
    case singleVolume = "/books/v1/volumes/"
}

enum SearchParameter: String {
    case title = "intitle"
    case author = "inauthor"
    case publisher = "inpublisher"
    case subject = "subject"
    case isbn = "isbn"
    case lccn = "lccn"
    case oclc = "oclc"
}

//  MARK: ERROR Handling
/// The most common errors that the JSON data can throw.
enum DownloadError: Error {
    case statusNotOK
    case decoderError
}

/// Adds a description to the error.
extension DownloadError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .statusNotOK:
            return NSLocalizedString(
                "Invalid Credentials",
                comment: ""
            )
        case .decoderError:
            let format = NSLocalizedString(
                "JSON Parse Error",
                comment: ""
            )
            return String(format: format)
        }
    }
}
