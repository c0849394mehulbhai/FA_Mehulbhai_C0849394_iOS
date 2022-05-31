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
    var arrayButton : [Int] = []
    
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
        
        f1.tag = 1
        f2.tag = 2
        f3.tag = 3
        s1.tag = 4
        s2.tag = 5
        s3.tag = 6
        t1.tag = 7
        t2.tag = 8
        t3.tag = 9
    }
    
    @IBAction func gameTapAction(_ sender: UIButton) {
        
        addTurnToBoard(sender)
        
        if checkWinMove(CROSS)
        {
            crosseWin += 1
            alertWinMessage(title: "Croses Win this game")
            PlayerX.text = "Win 0 : \(crosseWin)"

        }
        if checkWinMove(NOUGHT)
        {
            noughtWin += 1
            alertWinMessage(title: "Nought Win this game")
            PlayerO.text = "Win 0 : \(noughtWin)"

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
            var turn = ""
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
            arrayButton.append(sender.tag)
            var startPlayerTurn = ""
            if FirstUserTurn == .Cross {
                startPlayerTurn = "X"
            } else {
                startPlayerTurn = "O"
            }
            
            
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
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if let _ = arrayButton.last {
            
        if motion == .motionShake {
            undoGameState()
            var playerturn = ""
            if(CurrentUserTurn == playerTurn.Nought) {
                CurrentUserTurn = playerTurn.Cross
                playerTurnLbl.text = CROSS
                playerturn = "X"

            }
            else if(CurrentUserTurn == playerTurn.Cross) {
                CurrentUserTurn = playerTurn.Nought
                playerTurnLbl.text = NOUGHT
                playerturn = "O"
            }
        }
    }
    
    func undoGameState() {
        for button in buttonBoard {
            if button == f1 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == f2 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == f3 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == s1 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == s2 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == s3 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == t1 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == t2 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
            if button == t3 {
                button.setTitle(nil, for: .normal)
                button.isEnabled = true
            }
        }
    }
    
        func leftRightSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            let msg = "want to reset game ?"
            let alertControl = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
            alertControl.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
                self.resetGameBoard()
                self.PlayerX.text = "Win X :"
                self.PlayerO.text = "Win O :"
            }))
            self.present(alertControl, animated: true)
            
        case .left:
            let message = "RESET GAME?"
            let alertc = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            alertc.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
                self.resetGameBoard()
                self.PlayerX.text = "Win X :"
                self.PlayerO.text = "Win O :"
            }))
            self.present(alertc, animated: true)
            
        default:
            break
        }
    }
    
    func toMove(index : Int) -> playerMove {
        var move = playerMove.f1
        if index == 1 {
            move = .f1
        } else if index == 2 {
            move = .f2
        } else if index == 3 {
            move = .f3
        } else if index == 4 {
            move = .s1
        } else if index == 5 {
            move = .s2
        } else if index == 6 {
            move = .s3
        } else if index == 7 {
            move = .t1
        } else if index == 8 {
            move = .t2
        } else if index == 9 {
            move = .t3
        }
        return move
    }
    
    func nextMoveEnum(move : String) ->  playerTurn {
        if move == "X" {
            return playerTurn.Nought
        } else {
            return playerTurn.Cross
        }
        
    }
    
    func getNextMove(move : String) -> String {
        if move == "X" {
            return "O"
        } else {
            return "X"
        }
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

}
