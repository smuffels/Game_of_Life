//
//  ContentView.swift
//  Game of Life
//
//  Created on 04.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var logic = GameOfLifeLogic()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isDarkmode = false
    
    var body: some View {
        ZStack{
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack{
                ZStack{
                    Text("Game of Life").textStyle(size: 25)
                    HStack{
                        Spacer()
                        Button {isDarkmode.toggle()}
                        label: {Image(systemName: isDarkmode ? "sun.max.fill" : "sun.max")
                                .foregroundStyle(Color("alive"))
                                .font(.title2)
                                .padding()
                        }
                    }
                }.padding(.horizontal)
                //Regular View
                if horizontalSizeClass == .regular{
                    HStack{
                        BoardView(label: "start", boardSize: logic.boardSize, boardContent: logic.oldBoard)
                        BoardView(label: "next generation", boardSize: logic.boardSize, boardContent: logic.newBoard)
                    }
                    .padding()}
                //Compact View
                else{
                    VStack{
                        BoardView(label: "start", boardSize: logic.boardSize, boardContent: logic.oldBoard)
                            .padding(5)
                        BoardView(label: "next generation", boardSize: logic.boardSize, boardContent: logic.newBoard)
                        Spacer()
                    }
                    
                }
                
            }
            .preferredColorScheme(isDarkmode ? .dark: .light)
        }
        
    }
}

struct TextStyle: ViewModifier{
    var size: Double
    func body(content: Content) -> some View {
            content
            .foregroundStyle(Color("alive"))
            .font(.system(size: size, weight: .light, design: .serif))
            .italic()
        }
}

extension View{
    func textStyle(size: Double) -> some View {
        self.modifier(TextStyle(size: size))
    }
}


struct BoardView: View {
    var label: String
    var boardSize: Int
    var boardContent: [[Int]]
    
    var body: some View {
        GroupBox(label: Text(label).textStyle(size: 20)
            .frame(maxWidth: .infinity)){
            VStack(){
                ForEach(0..<boardSize, id: \.self) { row in
                    HStack(){
                        ForEach(0..<boardSize, id: \.self) { col in
                            Rectangle()
                                .fill(boardContent[row][col] == 1 ? Color("alive") : Color("dead"))
                                .frame(width: 15, height: 15)
                        }
                    }
                }
            }
        }
        .backgroundStyle(Color("boxBackground"))
        .frame(maxWidth:300)
        .aspectRatio(1, contentMode: .fit)
        
    }
}

#Preview {
    ContentView()
}
