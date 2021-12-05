//
//  SupplyRepo.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 05.12.2021.
//

import Foundation

public class SupplyRepo {
    
    enum SupplyRepoError: Swift.Error {
        case cannotCastToUrl
        case wrongStatusCode
        case noDataInResponse
        case invalidDataInResponse
        case unknownError
    }
    
    // MARK: - Private properties
    
    private let session = URLSession.shared
    
    private let sharedBaseUrl: String = "\(SharedAPIConfiguration.baseUrl)/\(SharedAPIConfiguration.api)/\(SharedAPIConfiguration.supply)"
}

// MARK: - Private methods

private extension SupplyRepo {
    
    func performSupplyTask(
        id: String,
        completion: @escaping (Result<SupplyModel, Error>) -> Void
    ) {
        struct SupplyModel: Codable {
            let id: String
        }
        
        guard let url = URL(string: self.sharedBaseUrl)
        else {
            completion(.failure(SupplyRepoError.cannotCastToUrl))
            return
        }
        
        let httpBody: SupplyModel = .init(
            id: id
        )
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            request.httpBody = try jsonEncoder.encode(httpBody)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200
                else {
                    completion(.failure(SupplyRepoError.wrongStatusCode))
                    return
                }
                
                do {
                    let decodedResponse = try self?.handleSupplyResponse(for: data)
                    
                    guard let decodedResponse = decodedResponse
                    else {
                        completion(.failure(SupplyRepoError.unknownError))
                        return
                    }
                    
                    completion(.success(decodedResponse.supply))
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
        )
        
        task.resume()
    }
    
    struct ResponseModel: Decodable {
        let supply: SupplyModel
    }
    
    func handleSupplyResponse(
        for data: Data?
    ) throws -> ResponseModel {
        
        guard let data = data
        else {
            throw SupplyRepoError.noDataInResponse
        }
        
        let response: ResponseModel
        do {
            response = try jsonDecoder.decode(
                ResponseModel.self,
                from: data
            )
        } catch let error {
            print(error)
            throw SupplyRepoError.invalidDataInResponse
        }
        
        return response
    }
}

// MARK: - SupplyAPIProtocol

extension SupplyRepo: SupplyAPIProtocol {
    
    public func getSupply(
        for id: String,
        completion: @escaping (Result<SupplyModel, Error>) -> Void
    ) {
        
        self.performSupplyTask(id: id, completion: completion)
        
    }
}
