//
//  Game_of_Life_Logic.swift
//  Game of Life
//
//  Created on 04.04.2025.
//

import Foundation;

class GameOfLifeLogic: ObservableObject{
    
    @Published var initialBoard: [[Int]];
    @Published var oldBoard: [[Int]];
    @Published var newBoard: [[Int]];
    @Published var counter: Int = 1;
    @Published var isEditable: Bool = false;
    
    let boardSize = 10;
    
    init() {
        self.initialBoard = Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize);
        self.oldBoard = Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize);
        self.newBoard = Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize);
        
        fillRandomly();
        calculateNext();
    }
    
    func fillRandomly(){
        for row in 0..<boardSize {
            for column in 0..<boardSize{
                oldBoard[row][column] = Int(arc4random() % 2);
            }
        }
        initialBoard = oldBoard
    }
    
    
    func calculateNext(){
        for row in 0..<boardSize {
            for column in 0..<boardSize{
                let currentCell = oldBoard[row][column]
                let aliveNeightbours = countAliveNeightbors(row: row, column: column)
                
                
                if(currentCell == 0){
                    //Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
                    if(aliveNeightbours == 3){
                        newBoard[row][column] = 1;
                    } else {
                        newBoard[row][column] = 0;
                    }
                } else{
                    //Any live cell with two or three live neighbours lives on to the next generation.
                    if(aliveNeightbours == 2 || aliveNeightbours == 3){
                        newBoard[row][column] = 1;
                    } else {
                        //Any live cell with fewer than two live neighbours dies, as if by underpopulation.
                        //Any live cell with more than three live neighbours dies, as if by overpopulation.
                        newBoard[row][column] = 0;
                    }
                    
                }
                
            }
        }
        
    }
    
    func countAliveNeightbors(row:Int, column:Int)->Int{
        var count = 0;
        for i in -1...1 {
            for j in -1...1 {
                
                if i == 0 && j == 0 { continue } //skip self
                
                let newRow = row + i
                let newCol = column + j
                
                
                // check if in bounds of the board
                if newRow >= 0 && newRow < boardSize && newCol >= 0 && newCol < boardSize {
                    count += oldBoard[newRow][newCol]
                }
            }
        }
        return count
    }
    
    func nextGen()
    {
        oldBoard = newBoard
        calculateNext()
        counter+=1
        isEditable=false
    }
    
    func toggleCell(row:Int, column: Int){
        if initialBoard[row][column] == 0 {
            initialBoard[row][column] = 1
        } else {
            initialBoard[row][column] = 0
        }
        oldBoard=initialBoard
        calculateNext()
    }
    
    func setStartManually(){
        
        isEditable = true
        initialBoard=Array(repeating: Array(repeating: 0, count: boardSize), count: boardSize)
        newBoard=initialBoard
        counter=1
    }
}
