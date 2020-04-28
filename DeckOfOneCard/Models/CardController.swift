//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Shannon Draeker on 4/28/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation
import UIKit.UIImage

class CardController {
    // Magic string for the api url
    static private let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    // Fetch a card from the api
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        // Make sure that the url works
        guard let finalURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        // Make the call to the api to get the card's data
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // Handle any errors
            if let error = error { return completion(.failure(.thrownError(error))) }
            
            // Confirm that the data exists
            guard let data = data else { return completion(.failure(.noData)) }
            
            // Try to decode the data and return it as a Card object
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                guard let card = topLevelDictionary.cards.first else { return completion(.failure(.noData)) }
                return completion(.success(card))
            } catch let decodingError {
                return completion(.failure(.thrownError(decodingError)))
            }
        }.resume()
    }
    
    // Fetch a card's image from the api
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        // Get the url for the card's image
        let finalURL = card.image
        
        // Make the call to the api to get the card's image
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // Handle any errors
            if let error = error { return completion(.failure(.thrownError(error))) }
            
            // Confirm that the data exists
            guard let data = data else { return completion(.failure(.noData)) }
            
            // Try to convert the data to an image
            guard let cardImage = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(cardImage))
            
        }.resume()
    }
}
