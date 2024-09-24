//
//  FlashcardCell.swift
//  MokDeborahHW6
//
//  Created by Deborah Mok on 3/7/24.
//

import SwiftUI

struct FlashcardCell: View {
    var flashcard: Flashcard
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(flashcard.question)
                .font(.title3)
            Text(flashcard.answer)
                .font(.subheadline)
        }
    }
}

#Preview {
    FlashcardCell(flashcard: Flashcard(id: UUID().uuidString, question: "1+1 = ?", answer: "2", isFavorite: false))
}
