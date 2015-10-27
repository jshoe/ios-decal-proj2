//
//  Hangman.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import Foundation

class Hangman {
    var phrases: HangmanPhrase!
    var answer: String?
    var knownString: String?
    var guessedLetters: NSMutableArray?
    
    // Initialize HangmanPhrase with all possible phrases of Hangman game
    init() {
        phrases = HangmanPhrase()
    }
    
    // Start the game, selecting a phrase from phrases. Also sets up the current known string
    // and guessedLetters array
    func start() -> String {
        print("Starting a new game")
        let phrase = phrases.getRandomPhrase()
        answer = phrase
        print("Word is " + answer!)
        knownString = ""
        for (var i = 0; i < answer!.characters.count; i += 1) {
            if (phrase as NSString).substringWithRange(NSMakeRange(i, 1)) == " " {
                knownString = knownString! + " "
            } else {
                knownString = knownString! + "_"
            }
        }
        guessedLetters = NSMutableArray()
        return knownString!
    }
    
    // Guess a letter, adding that letter to guessedLetters, and checking that letter against
    // the answer phrase. Returns whether or not the guess is correct.
    func guessLetter(letter: String) -> (Bool, String) {
        var isCorrect = false
        if guessedLetters!.containsObject(letter) {
            print("Was already guessed")
            return (true, knownString!)
        }
        guessedLetters!.addObject(letter)
        var chars = Array(answer!.characters)
        
        for (var i = 0; i < answer!.characters.count; i += 1) {
            if String(chars[i]) == letter {
                isCorrect = true
                print("Guess was in the word")
                knownString = "\((knownString! as NSString).substringToIndex(i))" + "\(letter)"
                            + "\((knownString! as NSString).substringFromIndex(i+1))"
                print("knownstring is: " + String(knownString))
            }
        }
        print("guess isCorrect: " + String(isCorrect))
        return (isCorrect, knownString!)
    }
    
    // Return a string of all letter guesses so far
    func guesses() -> String {
        print("Guessing letter")
        if guessedLetters!.count == 0 {
            return ""
        }
        var result: String! = " "
        for (var i = 0; i < guessedLetters!.count; i += 1) {
            let letter: String = (guessedLetters?.objectAtIndex(i))! as! String
            result = result + String(letter)
        }

        return result
    }

}