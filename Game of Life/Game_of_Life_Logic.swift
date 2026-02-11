//
//  Game_of_Life_Logic.swift
//  Game of Life
//
//  Created by Celine Brun on 04.04.2025.
//

import Foundation;

class GameOfLifeLogic: ObservableObject{
    
    @Published var oldBoard: [[Int]];
    @Published var newBoard: [[Int]];
    
    let size = 10;

    init() {
        self.oldBoard = Array(repeating: Array(repeating: 0, count: size), count: size);
        self.newBoard = Array(repeating: Array(repeating: 0, count: size), count: size);
        
        fillRandomly();
        calculateNext();
    }

    func fillRandomly(){
        for row in 0..<size {
            for column in 0..<size{
                oldBoard[row][column] = Int(arc4random() % 2);
            }
        }
    }
    
    
    func calculateNext(){
        for row in 0..<size {
            for column in 0..<size{
                let currentCell = oldBoard[row][column]
                let aliveNeightbours = countAliveNeightbors(row: row, column: column)
                
                
                if(currentCell == 0){
                    //dead
                    if(aliveNeightbours == 3){
                        newBoard[row][column] = 1;
                    } else {
                        newBoard[row][column] = 0;
                    }
                    //Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
                } else{
                    //alive
                    if(aliveNeightbours == 2 || aliveNeightbours == 3){
                        newBoard[row][column] = 1;
                    } else {
                        newBoard[row][column] = 0;
                    }
                    /*
                     Any live cell with fewer than two live neighbours dies, as if by underpopulation.
                     Any live cell with two or three live neighbours lives on to the next generation.
                     Any live cell with more than three live neighbours dies, as if by overpopulation.
                     */
                }
                
            }
        }
    }
    
    func countAliveNeightbors(row:Int, column:Int)->Int{
        var count = 0;
        for i in -1...1 {
            for j in -1...1 {
                
                if i == 0 && j == 0 { continue } //skip sich selbst
                
                let newRow = row + i
                let newCol = column + j
                
                // Stelle sicher, dass man nicht außerhalb des Arrays liest
                if newRow >= 0 && newRow < size && newCol >= 0 && newCol < size {
                    count += oldBoard[newRow][newCol]
                }
            }
        }
        return count
    }
    
}
