//
//  WarehousesWorker.swift
//  TripleS
//
//  Created by Andrey Karpenko  on 24.12.2021.
//

import Foundation

public class WarehouseRepo {
    
    enum WarehouseRepoError: Swift.Error {
        case cannotCastToUrl
        case wrongStatusCode
        case noDataInResponse
        case invalidDataInResponse
        case unknownError
    }
    
    // MARK: - Private properties
    
    private let session = URLSession.shared
    
    private let sharedBaseUrl: String = "\(SharedAPIConfiguration.baseUrl)/\(SharedAPIConfiguration.api)/\(SharedAPIConfiguration.warehouses)"
    private let productsLeft: String = "products-left"
    private let boxes: String = "boxes"
    private let useBox: String = "use-box"
    private let writeOff: String = "write-off"
}

// MARK: - Private methods
private extension WarehouseRepo {
    func getWarehouses(completion: @escaping (Result<[Warehouse], Error>) -> Void) {
        
        guard let url = URL(string: self.sharedBaseUrl)
        else {
            completion(.failure(WarehouseRepoError.cannotCastToUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setToken(accountWorker.token)
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (response.statusCode == 200 || response.statusCode == 204)
                else {
                    completion(.failure(WarehouseRepoError.wrongStatusCode))
                    return
                }
                
                guard let data = data
                else {
                    completion(.failure(WarehouseRepoError.noDataInResponse))
                    return
                }
                
                do {
                    let decodedResponse = try jsonDecoder.decode(
                        [Warehouse].self,
                        from: data
                    )
                    
                    completion(.success(decodedResponse))
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
        )
        
        task.resume()
    }
    
    struct BoxCodable: Codable {
        let id: String
        let countLeft: Int
        let spoilDate: SharedDateModel
        let wareHouseId: String
        let supplyProduct: SupplyProductCodable
        
        struct SupplyProductCodable: Codable {
            
            let product: ProductCodable
            
            struct ProductCodable: Codable {
                
                let name: String
                let description: String?
                let unit: UnitCodable
                
                struct UnitCodable: Codable {
                    let name: String
                }
            }
        }
    }
    
    func getBoxes(
        for warehouseId: String,
        completion: @escaping (Result<[Box], Error>) -> Void
    ) {
        
        guard let url = URL(string: "\(self.sharedBaseUrl)/\(warehouseId)/\(self.boxes)")
        else {
            completion(.failure(WarehouseRepoError.cannotCastToUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setToken(accountWorker.token)
        
        let task: URLSessionDataTask = self.session.dataTask(
            with: request,
            completionHandler: { [weak self] (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (response.statusCode == 200 || response.statusCode == 204)
                else {
                    completion(.failure(WarehouseRepoError.wrongStatusCode))
                    return
                }
                
                guard let data = data
                else {
                    completion(.failure(WarehouseRepoError.noDataInResponse))
                    return
                }
                
                do {
                    let decodedResponse = try jsonDecoder.decode(
                        [BoxCodable].self,
                        from: data
                    )
                    
                    completion(.success(decodedResponse.mapToBoxes()))
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
        )
        
        task.resume()
    }
        
    func postUseBox(
        for id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let stringURL: String = "\(self.sharedBaseUrl)/\(self.boxes)/\(self.writeOff)/\(id)"
        
        guard let url = URL(string: stringURL)
        else {
            completion(.failure(WarehouseRepoError.cannotCastToUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setToken(accountWorker.token)
        do {
            request.httpBody = try jsonEncoder.encode(id)
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
                      (response.statusCode == 200 || response.statusCode == 204)
                else {
                    completion(.failure(WarehouseRepoError.wrongStatusCode))
                    return
                }
                completion(.success(()))
            }
        )
        
        task.resume()
    }
    
    func postWriteOffBox(
        for id: String,
        count: Int,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        var urlComponents = URLComponents(string: "\(self.sharedBaseUrl)/\(self.boxes)/\(self.useBox)/\(id)")
        urlComponents?.queryItems = [
            .init(name: "count", value: "\(count)")
        ]
        
        guard let url = urlComponents?.url
        else {
            completion(.failure(WarehouseRepoError.cannotCastToUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.setToken(accountWorker.token)
        do {
            request.httpBody = try jsonEncoder.encode(id)
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
                      (response.statusCode == 200 || response.statusCode == 204)
                else {
                    completion(.failure(WarehouseRepoError.wrongStatusCode))
                    return
                }
                completion(.success(()))
            }
        )
        
        task.resume()
    }
}

extension WarehouseRepo: WarehouseAPIProtocol {
    public func fetchWarehouses(completion: @escaping (Result<[Warehouse], Error>) -> Void) {
        self.getWarehouses(completion: completion)
    }
    
    public func fetchBoxes(
        for warehouseId: String,
        completion: @escaping (Result<[Box], Error>) -> Void
    ) {
        
        self.getBoxes(
            for: warehouseId,
            completion: completion
        )
    }
    
    public func performUseBox(
        for id: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        
        self.postUseBox(
            for: id,
            completion: completion
        )
    }
    
    public func performWriteOff(
        for id: String,
        count: Int,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        
        self.postWriteOffBox(
            for: id,
            count: count,
            completion: completion
        )
    }
}

private extension Array where Element == WarehouseRepo.BoxCodable {
    
    func mapToBoxes() -> [Box] {
        
        return self.compactMap { (box) -> Box? in
            return .init(
                id: box.id,
                warehouseId: box.wareHouseId,
                productName: box.supplyProduct.product.name,
                spoilDate: box.spoilDate.value,
                count: box.countLeft,
                unit: box.supplyProduct.product.unit.name
            )
        }
    }
}
