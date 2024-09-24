//
//  EditFlashCardPage.swift
//  MokDeborahHW6
//
//  Created by Deborah Mok on 3/6/24.
//

import SwiftUI

struct EditFlashCardPage: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var flashcardViewModel : FlashcardViewModel
    private var flashcard : Flashcard?
    @State private var question = ""
    @State private var answer = ""
    @State private var isFavorite = false
    
    init(flashcard: Flashcard? = nil){
        guard let flashcard else {
            return
        }
        self.flashcard = flashcard
        _question = State(initialValue: flashcard.question)
        _answer = State(initialValue: flashcard.answer)
        _isFavorite = State(initialValue: flashcard.isFavorite)
        
    }
    
    var body: some View {
        //Spacer()
        VStack{
            if (flashcard != nil) {
                TextField(flashcard!.question, text: $question)
                TextField(flashcard!.answer, text: $answer)
                
                Toggle(isOn: $isFavorite, label: {
                    Text("Is favorite?")
                })
            }
            else
            {
                TextField("Question", text: $question)
                TextField("Answer", text: $answer)
                
                Toggle(isOn: $isFavorite, label: {
                    Text("Is favorite?")
                })
            }
            
        }
        .padding()
        .navigationTitle(flashcard == nil ? "New Card" : "Edit Card")
        .toolbar{
            Button("Save"){
                if (flashcard != nil){
                    let updateFlashcard = Flashcard(id: flashcard!.id, question: question, answer: answer, isFavorite: isFavorite)
                    let curIdx = flashcardViewModel.getIndex(for: flashcard!)
                    flashcardViewModel.update(flashcard: updateFlashcard, at: curIdx!)
                }
                else{
                    flashcardViewModel.append(flashcard: Flashcard(id: UUID().uuidString, question: question, answer: answer, isFavorite: isFavorite))
                }
                dismiss()
            }
            .disabled(question == "" || answer == "")
        }
    }
}

#Preview {
    EditFlashCardPage()
}
