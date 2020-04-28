//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Shannon Draeker on 4/28/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var valueAndSuitLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    // MARK: - Actions
    
    @IBAction func drawCardButtonTapped(_ sender: UIButton) {
        // Call the fuction in the CardController to fetch a new card
        CardController.fetchCard { [weak self] (result) in
            // Make sure any changes to the UI happen on the main thread
            DispatchQueue.main.async {
                
                switch result {
                case .success(let card):
                    // If the card was formed correctly, get its image and update the ui with the card's information
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    // If there was an error, display it to the user
                    self?.presentErrorToUser(error)
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func fetchImageAndUpdateViews(for card: Card) {
        // Call the function in the CardController to fetch the card's image
        CardController.fetchImage(for: card) { [weak self] (result) in
             // Make sure any changes to the UI happen on the main thread
            DispatchQueue.main.async {
                
                switch result {
                case .success(let cardImage):
                    // If the image is correct, update the ui fields of the view
                    self?.valueAndSuitLabel.text = "\(card.value) of \(card.suit)"
                    self?.cardImageView.image = cardImage
                case .failure(let error):
                    // If there was an error, display it to the user
                    self?.presentErrorToUser(error)
                }
            }
        }
    }
}
