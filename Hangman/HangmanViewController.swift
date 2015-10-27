//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    @IBOutlet var newGameButton: UIBarButtonItem!
    @IBOutlet var guessField: UITextField!
    @IBOutlet var guessLabel: UILabel!
    @IBOutlet var hangmanView: UIImageView!
    @IBOutlet var knownString: UILabel!
    
    var HangmanState = Hangman()
    var curGuesses = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        newGame()
        print("Loading view")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func newGame() {
        knownString.text = HangmanState.start()
        guessLabel.text = ""
        curGuesses = 1
        hangmanView.image = UIImage(named: "hang1.png")
    }
    
    func loadInterface() {
        newGameButton.action = "newGame"
        print("Set interface button")
    }
    
    func refresh() {
        guessLabel.text = HangmanState.guesses()
    }
    
    func winGame() {
        let alert = UIAlertController(title: "You won!", message: "Want to play again?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.Default, handler: {action in
            switch action.style {
            case .Default:
                self.newGame()
            default:
                print("hello")
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loseGame() {
        let alert = UIAlertController(title: "You lost the game!", message: "Want to play again?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "New Game", style: UIAlertActionStyle.Default, handler: {action in
            switch action.style {
            case .Default:
                self.newGame()
            default:
                print("hello")
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func guessLetter(sender: UIButton) {
        print("guessLetter called")
        let result = HangmanState.guessLetter(guessField.text!.uppercaseString)
        knownString.text = result.1
        if result.1.rangeOfString("_") == nil {
            winGame()
        }
        if result.0 == false {
            curGuesses += 1
            let curImage = "hang" + String(curGuesses) + ".png"
            hangmanView.image = UIImage(named: curImage)
        }
        if curGuesses >= 7 {
            loseGame()
        }
        self.view.endEditing(true)
        guessField.text = ""
        refresh()
    }
}