//
//  FlashcardPage.swift
//  MokDeborahHW6
//
//  Created by Deborah Mok on 3/7/24.
//

import SwiftUI

//fileprivate let screenHeight = UIScreen.main.bounds.size.height

struct FlashcardPage: View {
    
    let OFFSET_X = 300.0
    let OFFSET_Y = 900.0
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    @State var isShowingQuestion = true
    @State var offsetX = 0.0
    @State var offsetY = 0.0
    @State var isHidden = false
    
    //computed properties: using the current values to compute certain values
    var title: String{
        if let flashcard = flashcardViewModel.currentFlashcard{
            //swift doesn't know where to get currentFlashCard from so we use a singleton to unwrap that value
            if isShowingQuestion{
                return flashcard.question
            }
            else{
                return flashcard.answer
            }
        }
        else{
            return ""
        }
    }
    
    var isFavorite: Bool{
        let flashcard = flashcardViewModel.currentFlashcard
        if let flashcard{
            return flashcard.isFavorite
        }
        else{
            return false
        }
    }
    
    func showRandomFlashCard() {
        withAnimation(
            .linear
        ){
            offsetY = -OFFSET_Y
            isHidden = true
        }
        withAnimation(
            .linear
                .delay(0.5)
        ){
            offsetY = OFFSET_Y
            isShowingQuestion = true
            flashcardViewModel.randomize()
        }
        withAnimation(
            .linear
                .delay(1)
        ){
            offsetY = 0
            isHidden = false
        }
    }
    
    func toggleQuestionAnswer(){
        isShowingQuestion.toggle()
    }
    
    func showNextCard(){ //it's running in parallel
        withAnimation(
            .linear
        ){
            offsetX = -OFFSET_X
            isHidden = true
        }
        withAnimation(
            .linear
                .delay(0.5)
            //moving the viewstack to right
        ){
            offsetX = OFFSET_X
            isShowingQuestion = true
            flashcardViewModel.next()
        }
        withAnimation(
            .linear
                .delay(1)
        ){
            offsetX = 0
            isHidden = false
        }
    }
    
    func showPreviousCard(){
        withAnimation(
            .linear
        ){
            offsetX = OFFSET_X
            isHidden = true
        }
        withAnimation(
            .linear
                .delay(0.5)
        ){
            offsetX = -OFFSET_X
            isShowingQuestion = true
            flashcardViewModel.previous()
        }
        withAnimation(
            .linear
                .delay(1)
        ){
            offsetX = 0
            isHidden = false
        }
    }
    
    var body: some View {
        ZStack{
            VStack {
                //Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        flashcardViewModel.toggleFavorite()
                    }) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .tint(isFavorite ? .yellow : .gray)
                            .frame(width: 50, height: 50)
                    }
                    .padding()
                }
                Spacer()
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(isShowingQuestion ? Color.black : Color.blue)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.cyan)
            .onTapGesture (count: 2){
                toggleQuestionAnswer()
            }
            .onTapGesture (count: 1){
                print("1 tap")
                showRandomFlashCard()
                
            }
            .padding()
            .opacity(isHidden ? 0.0 : 1.0) //tetiarary
            .offset(x: offsetX, y: offsetY)
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    print(value.translation)
                    switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30): //left swipe
                        //print("left swipe")
                        showNextCard()
                    case (0..., -30...30): //right swipe
                        //print("right swipe")
                        showPreviousCard()
                    case (-100...100, ...0):
                        print("up swipe")
                    case (-100...100, 0...):
                        print("down swipe")
                    default:
                        print("no clue")
                    }
                }
            )
            .padding()
        }
    }
}

#Preview {
    FlashcardPage()
}
