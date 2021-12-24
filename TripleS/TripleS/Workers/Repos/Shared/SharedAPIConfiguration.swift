import Foundation

public enum SharedAPIConfiguration {
    
    static let baseUrl: String = "https://triples-api.azurewebsites.net"
    
    static let api: String = "api"
    static let account: String = "Account"
    static let product: String = "Product"
    static let role: String = "Role"
    static let unit: String = "Unit"
    static let users: String = "Users"
    static let supply: String = "Supply"
    static let supplyProduct: String = "supply-product"
    static let supplyProducts: String = "supply-products"
    static let warehouses: String = "WareHouses"
    
    static let login: String = "login"
    static let register: String = "register"
    static let receive: String = "receive"
    
    static let roles: String = "roles"
    static let units: String = "units"
//    static let users: String = "users"
}

// MARK: - Public JSON coders

/// JSON encoder
public let jsonEncoder: JSONEncoder = {
    let encoder: JSONEncoder = .init()
    encoder.keyEncodingStrategy = .useDefaultKeys
    return encoder
}()

/// JSON decoder
public let jsonDecoder: JSONDecoder = {
    let decoder: JSONDecoder = .init()
    decoder.keyDecodingStrategy = .useDefaultKeys
    return decoder
}()
