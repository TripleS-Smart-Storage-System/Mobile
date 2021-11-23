//
//  PasswordChangeError.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 23.11.2021.
//

import Foundation

enum PasswordChangeError: Error {
    case passwordMismatch
    case insufficientLength
    case noCapitalLetters
    case someEmptyFields
}
