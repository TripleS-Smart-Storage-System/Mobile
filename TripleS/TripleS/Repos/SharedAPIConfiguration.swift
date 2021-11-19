import Foundation

public enum SharedAPIConfiguration {
    
    static let baseUrl: String = "https://triples-api.azurewebsites.net"
    
    static let api: String = "api"
    static let account: String = "Account"
    static let product: String = "Product"
    static let role: String = "Role"
    static let unit: String = "Unit"
    
    static let login: String = "login"
    static let register: String = "register"
    static let roles: String = "roles"
    static let units: String = "units"
    static let users: String = "users"
}

// MARK: - Public JSON coder

/// Snake case JSON encoder
public let jsonEncoder: JSONEncoder = {
    let encoder: JSONEncoder = .init()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
}()

/// Snake case JSON decoder
public let jsonDecoder: JSONDecoder = {
    let decoder: JSONDecoder = .init()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()
