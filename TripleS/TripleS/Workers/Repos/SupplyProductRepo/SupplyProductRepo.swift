//
//  SupplyProductRepo.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 06.12.2021.
//

import Foundation

public class SupplyProductRepo {
    
    enum SupplyRepoError: Swift.Error {
        case cannotCastToUrl
        case wrongStatusCode
        case noDataInResponse
        case invalidDataInResponse
        case unknownError
    }
    
    // MARK: - Private properties
    
    private let session = URLSession.shared
    
    private let sharedBaseUrl: String = "\(SharedAPIConfiguration.baseUrl)/\(SharedAPIConfiguration.api)/\(SharedAPIConfiguration.supplyProducts)"
}

// MARK: - Private methods

private extension SupplyProductRepo {
    
    func performGetSupplyProductTask(
        id: String,
        completion: @escaping (Result<SupplyProductModel, Error>) -> Void
    ) {
        
        guard let url = URL(string: "\(self.sharedBaseUrl)/\(id)")
        else {
            completion(.failure(SupplyRepoError.cannotCastToUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setToken(accountWorker.token)
        
//        do {
//            request.httpBody = try jsonEncoder.encode(id)
//        } catch let error {
//            completion(.failure(error))
//            return
//        }
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                
                print(data)
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (response.statusCode == 200 || response.statusCode == 204)
                else {
                    completion(.failure(SupplyRepoError.wrongStatusCode))
                    return
                }
                
                do {
                    let decodedResponse = try self?.handleSupplyProductResponse(for: data)
                    
                    guard let decodedResponse = decodedResponse
                    else {
                        completion(.failure(SupplyRepoError.unknownError))
                        return
                    }
                    
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
        )
        
        task.resume()
    }
    
    func performPostSupplyProductReceiveTast(
        id: String,
        productionDate: Date,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        struct SupplyProductModel: Codable {
            let id: String
            let productionDate: Date
        }
        
        let stringURL: String = "\(self.sharedBaseUrl)/\(SharedAPIConfiguration.receive)/\(id)"
        
        guard let url = URL(string: stringURL)
        else {
            completion(.failure(SupplyRepoError.cannotCastToUrl))
            return
        }
        
        let httpBody: SupplyProductModel = .init(
            id: id,
            productionDate: productionDate
        )
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setToken(accountWorker.token)
        
        do {
            request.httpBody = try jsonEncoder.encode(httpBody)
        } catch let error {
            completion(.failure(error))
            return
        }
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { (_, response, error) in
                
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
                completion(.success(()))
            }
        )
        
        task.resume()
        
    }
    
    func handleSupplyProductResponse(
        for data: Data?
    ) throws -> SupplyProductModel {
        
        guard let data = data
        else {
            throw SupplyRepoError.noDataInResponse
        }
        
        let response: SupplyProductModel
        do {
            response = try jsonDecoder.decode(
                SupplyProductModel.self,
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

extension SupplyProductRepo: SupplyProductAPIProtocol {
    
    public func getSupplyProduct(
        for id: String,
        completion: @escaping (Result<SupplyProductModel, Error>) -> Void
    ) {
        
        self.performGetSupplyProductTask(id: id, completion: completion)
        
    }
    
    public func postSupplyProductReceive(
        for id: String,
        productionDate: Date,
        completion: @escaping (Result<Void, Error>) -> Void) {
            
        self.performPostSupplyProductReceiveTast(
            id: id,
            productionDate: productionDate,
            completion: completion)
        
    }
}
