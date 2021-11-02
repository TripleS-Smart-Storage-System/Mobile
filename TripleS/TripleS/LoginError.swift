//
//  LoginError.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 02.11.2021.
//

import Foundation

enum LoginError: Error {
    case incompleteForm
    case invalidUsername
    case incorrectPasswordLength
    case mismatchedPasswords
}
