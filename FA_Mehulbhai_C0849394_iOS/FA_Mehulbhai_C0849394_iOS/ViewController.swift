//
//  ViewController.swift
//  FA_Mehulbhai_C0849394_iOS
//
//

import UIKit

class ViewController: UIViewController {
    
    //first 3 horizontal buttton
    @IBOutlet weak var f1: UIButton!
    @IBOutlet weak var f2: UIButton!
    @IBOutlet weak var f3: UIButton!
    
    //second 3 horizontal button
    @IBOutlet weak var s1: UIButton!
    @IBOutlet weak var s2: UIButton!
    @IBOutlet weak var s3: UIButton!
    
    //second 3 horizontal button
    @IBOutlet weak var t1: UIButton!
    @IBOutlet weak var t2: UIButton!
    @IBOutlet weak var t3: UIButton!
    
    @IBOutlet weak var PlayerX: UILabel!
    @IBOutlet weak var PlayerO: UILabel!
    
    @IBOutlet weak var playerTurnLbl: UILabel!
    
    var buttonBoard = [UIButton]()
    
    var NOUGHT = "0"
    var CROSS = "X"
    
    //initialize with 0 score
    var noughtWin = 0
    var crosseWin = 0
    
    enum playerTurn {
        case Nought
        case Cross
    }

    var FirstUserTurn = playerTurn.Cross
    var CurrentUserTurn = playerTurn.Cross
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        initializeGame()
    }

    func initializeGame() {
        buttonBoard.append(f1)
        buttonBoard.append(f2)
        buttonBoard.append(f3)
        buttonBoard.append(s1)
        buttonBoard.append(s2)
        buttonBoard.append(s3)
        buttonBoard.append(t1)
        buttonBoard.append(t2)
        buttonBoard.append(t3)
    }
    
    @IBAction func gameTapAction(_ sender: UIButton) {
        
        addTurnToBoard(sender)
        
        if checkWinMove(CROSS)
        {
            crosseWin += 1
            alertWinMessage(title: "Croses Win this game")
        }
        if checkWinMove(NOUGHT)
        {
            noughtWin += 1
            alertWinMessage(title: "Nought Win this game")
        }
        if(checkWholeGameBoard()) {
            alertWinMessage(title: "this game is Draw !")
        }
    }
    
    func checkWholeGameBoard() -> Bool {
        for button in buttonBoard {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addTurnToBoard(_ sender : UIButton) {
        if(sender.title(for: .normal) == nil) {
            if(CurrentUserTurn == playerTurn.Nought) {
                sender.setTitle(NOUGHT, for: .normal)
                CurrentUserTurn = playerTurn.Cross
                playerTurnLbl.text = CROSS
            }
            else if(CurrentUserTurn == playerTurn.Cross){
                sender.setTitle(CROSS, for: .normal)
                CurrentUserTurn = playerTurn.Nought
                playerTurnLbl.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
    func checkWinMove(_ s : String) -> Bool {
        
        //check for vertical win
        if(buttonSymbol(f1, s) && buttonSymbol(s1, s) && buttonSymbol(t1, s)) {
            return true
        }
        if(buttonSymbol(f2, s) && buttonSymbol(s2, s) && buttonSymbol(t2, s)) {
            return true
        }
        if(buttonSymbol(f3, s) && buttonSymbol(s3, s) && buttonSymbol(t3, s)) {
            return true
        }
        
        //check for horizontal win
        if buttonSymbol(f1, s) && buttonSymbol(f2, s) && buttonSymbol(f3, s) {
            return true
        }
        if buttonSymbol(s2, s) && buttonSymbol(s2, s) && buttonSymbol(s3, s) {
            return true
        }
        if buttonSymbol(t1, s) && buttonSymbol(t2, s) && buttonSymbol(t3, s) {
            return true
        }
        
        // check for diagonal win
        if buttonSymbol(f1, s) && buttonSymbol(s2, s) && buttonSymbol(t3, s) {
            return true
        }
        if buttonSymbol(f3, s) && buttonSymbol(s2, s) && buttonSymbol(t1, s) {
            return true
        }
        return false
    }
           
    func alertWinMessage(title : String) {
        let alertMessgae = "\nNoughts " + String(noughtWin) + "\n\nCross" + String(crosseWin)
        let msg = UIAlertController(title: title, message: alertMessgae, preferredStyle: .actionSheet)
            msg.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
                self.resetGameBoard()
            }))
            self.present(msg, animated: true)
    }
                          
    func resetGameBoard() {
        for button in buttonBoard {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if FirstUserTurn == playerTurn.Nought {
            FirstUserTurn = playerTurn.Cross
            playerTurnLbl.text = CROSS
        }
        else if FirstUserTurn == playerTurn.Cross {
            FirstUserTurn = playerTurn.Nought
            playerTurnLbl.text = NOUGHT
        }
        CurrentUserTurn = FirstUserTurn
    }
    
    func buttonSymbol(_ button: UIButton, _ symbol : String) -> Bool {
        return button.title(for: .normal) == symbol
    }
}

enum playerMove : String {
    case f1
    case f2
    case f3
    case s1
    case s2
    case s3
    case t1
    case t2
    case t3
}


