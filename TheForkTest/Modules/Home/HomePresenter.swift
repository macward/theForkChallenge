//
//  HomePresenter.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    var view: HomeViewProtocol!
    
    func handleSuccessResponse(_ restaurants: [Restaurant]) {
        view.updateContent(restaurants)
    }
    
    func handleFavSuccessResponse(_ favorites: [String]) {
        view.updateFavorites(favorites)
    }
    
    func handleFailure(message: String) {
        view.showError(message: message)
    }
}
