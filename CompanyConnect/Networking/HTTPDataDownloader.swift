//
//  HTTPDataDownloader.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/25/24.
//

import Foundation

protocol HTTPDataDownloader {
    func getData<T: Decodable>(as type: T.Type, from url: URL) async throws -> T
}

extension HTTPDataDownloader {
    func getData<T: Decodable>(as type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw HTTPDataDownloaderError.BadResponse
        }

        guard response.statusCode == 200 else {
            throw HTTPDataDownloaderError.BadStatusCode(code: response.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(type, from: data)
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
