//
//  FlashcardViewModel.swift
//  MokDeborahHW6
//
//  Created by Deborah Mok on 3/6/24.
//

import Foundation

class FlashcardViewModel : FlashcardsModel, ObservableObject{
    private var flashcardsFilePath : URL
    @Published var flashcards: [Flashcard] = []{
        didSet {
            save()
        }
    }
    @Published var currentIndex = 0{
        didSet {
            //not to go out of bounds
            if currentIndex < 0 || currentIndex >= flashcards.count{
                print("Out of bounds")
            }
        }
    }
    
    init() {
        flashcardsFilePath = FileManager.default.urls(for: .documentDirectory,
                                                      in: .userDomainMask).first!.appendingPathComponent("flashcards.json")
        // try to load flashcards
        if let flashcards = load() {
            self.flashcards = flashcards
        }
        
        if (flashcards.isEmpty)
            {
            append(flashcard: Flashcard(id: UUID().uuidString, question: "1+1 = ?", answer: "2", isFavorite: false))
            append(flashcard: Flashcard(id: UUID().uuidString, question: "1+2 = ?", answer: "3", isFavorite: false))
            append(flashcard: Flashcard(id: UUID().uuidString, question: "5*5 = ?", answer: "25", isFavorite: true))
            append(flashcard: Flashcard(id: UUID().uuidString, question: "25*2 = ?", answer: "50", isFavorite: true))
            append(flashcard: Flashcard(id: UUID().uuidString, question: "Has life been good to you?", answer: "50", isFavorite: true))
        }
    }
    
    
    // Attempts to read from disk and decodes from JSON into Swift objects
    private func load() -> [Flashcard]?{
        // Your implementation here
        do {
            let data = try Data(contentsOf: flashcardsFilePath)
            let flashcards = try JSONDecoder().decode([Flashcard].self, from: data)
            return flashcards
        } catch {
            return nil
        }
    }
    
    // Attemps to encodes Swift objects into JSON and saves to disk
    private func save(){
        // Your implementation here
        do {
            let data = try JSONEncoder().encode(flashcards)
            try data.write(to: flashcardsFilePath)
        } catch {
            print("Error saving flashcards: \(error)")
        }
    }
    
    var numberOfFlashcards: Int {
        return flashcards.count
    }
    
    var currentFlashcard: Flashcard? {
        if (flashcards.isEmpty){
            return nil;
        }
        return flashcard(at: currentIndex)
    }
    
    var favoriteFlashcards: [Flashcard] = []
    
    func randomize(){
        let size = flashcards.count
        currentIndex = Int.random(in: 0 ..< size) //(in: 0 ..< size) is a while loop
    }
    
    func next(){
        //Increments the currentIndex by one
        if currentIndex == (flashcards.count - 1){
            currentIndex = 0
        }
        else{
            currentIndex += 1
        }
    }
    
    func previous(){
        if currentIndex == 0 {
            currentIndex = flashcards.count - 1
        }
        else{
            currentIndex -= 1
        }
    }
    
    func flashcard(at index: Int) -> Flashcard?{
        if (index > flashcards.count - 1) || (index < 0){
            return nil;
        }
        return flashcards[index]
    }
    
    func append(flashcard: Flashcard){
        flashcards.append(flashcard)
    }
    
    func insert(flashcard: Flashcard, at index: Int){
        if (index > flashcards.count - 1) || (index < 0){
            append(flashcard: flashcard)
        }
        else{
            flashcards.insert(flashcard, at: index)
        }
    }
    
    func removeFlashcard(at index: Int){
        if (index >= 0 && index <= flashcards.count - 1){
            flashcards.remove(at: index)
        }
        else{
            return
        }
    }
    
    func getIndex(for flashcard: Flashcard) -> Int?{
        var index = 0;
        for i in flashcards{
            if i == flashcard{
                return index
            }
            index += 1
        }
        return nil
    }
    
    func update(flashcard: Flashcard, at index: Int){
        flashcards[index] = flashcard
    }
    
    func toggleFavorite(){
//        // safely unwrap
//        if let currentFlashcard {
//            <#statements#>
//        } else {
//
//        }
//        guard let currentFlashcard else { return  }
//
//        // force unwrap
//        currentFlashcard!
        if let currentFlashcard{
            update(flashcard: .init(id: currentFlashcard.id, question: currentFlashcard.question, answer: currentFlashcard.answer, isFavorite: !currentFlashcard.isFavorite), at: currentIndex)
        } //if let unwraps -> it's an optional value ALWAYS UNWRAP
        updateFavorite()
    }
    
    func updateFavorite(){
        favoriteFlashcards = flashcards.filter({$0.isFavorite})
    }
}
