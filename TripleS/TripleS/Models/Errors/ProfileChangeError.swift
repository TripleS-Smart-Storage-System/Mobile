//
//  ProfileChangeError.swift
//  TripleS
//
//  Created by Mykhailo Zorin on 23.11.2021.
//

import Foundation

enum ProfileChangeError : Error {
    case someEmptyFields
    case nameTooShort
    case surnameTooShort
}
