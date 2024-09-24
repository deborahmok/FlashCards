//
//  FavoritesFlashcardListPage.swift
//  MokDeborahHW6
//
//  Created by Deborah Mok on 3/7/24.
//

import SwiftUI

struct FavoritesFlashcardListPage: View {
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
    var body: some View {
        NavigationStack{
            List ($flashcardViewModel.flashcards){ $flashcard in
                if (flashcard.isFavorite){
                    NavigationLink(value: flashcard) {
                        FlashcardCell(flashcard: flashcard) //first part is the label that was defined in FlashcardCell, and second part if passing in the $flashcard (the for loop)
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: Flashcard.self) { flashcard in
                EditFlashCardPage(flashcard: flashcard)
            }
        }
    }
}

#Preview {
    FavoritesFlashcardListPage()
}
