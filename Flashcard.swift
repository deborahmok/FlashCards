//
//  Flashcard.swift
//  MokDeborahHW6
//
//  Created by Deborah Mok on 3/6/24.
//
import Foundation

struct Flashcard: Hashable, Identifiable, Codable{
    let id : String
    let question : String
    let answer : String
    let isFavorite : Bool
}
