//
//  HTTPDataDownloader.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/25/24.
//

import Foundation

protocol HTTPDataDownloaderProtocol {
    func getData<T: Decodable>(as type: T.Type, from url: URL) async throws -> T
}

class HTTPDataDownloader: HTTPDataDownloaderProtocol {
    func getData<T: Decodable>(as type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw HTTPDataDownloaderError.BadResponse
        }

        guard response.statusCode == 200 else {
            throw HTTPDataDownloaderError.BadStatusCode(code: response.statusCode)
        }

        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw HTTPDataDownloaderError.DecodeingError(error: error.localizedDescription)
        }
    }

}

enum HTTPDataDownloaderError: Error {
    case BadResponse
    case BadStatusCode(code: Int)
    case DecodeingError(error: String)
}
