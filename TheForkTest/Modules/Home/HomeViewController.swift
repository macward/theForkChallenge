//
//  HomeViewController.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import UIKit

class HomeViewController: UIViewController,
                            HomeViewProtocol,
                            UITableViewDelegate,
                            UITableViewDataSource,
                          RestaurantCellDelegate {
    
    var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    var interactor: HomeInteractorProtocol!
    private var restaurants: [Restaurant] = []
    private var favorites: [String] = []
    init(interactor: HomeInteractorProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.interactor = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        title = "Restaurants"
        
        view.addSubview(tableView)
        
        tableView.register(UINib(nibName: "RestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: "restoCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "sort"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapFilterButton(_:)))
        navigationItem.rightBarButtonItem = filterButton
        
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(refreshControl:)),
                                 for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getFavorites()
        interactor.getRestaurants()
    }
    
    func updateContent(_ restaurante: [Restaurant]) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        self.restaurants = restaurante
        self.tableView.reloadIfNeeded()
    }
    
    func updateFavorites(_ favorites: [String]) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        self.favorites = favorites
        self.tableView.reloadIfNeeded()
    }
    
    func showError(message: String) {
        self.refreshControl.endRefreshing()
        let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restoCell", for: indexPath) as! RestaurantTableViewCell
        cell.setup(restaurants[indexPath.row], isFav: favorites.contains(restaurants[indexPath.row].uuid))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
       DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
           DispatchQueue.main.async {
               self.interactor.getFavorites()
               self.interactor.getRestaurants()
           }
       }
   }
    
    @objc func didTapFilterButton(_ sender: UIBarButtonItem) {
        let sortActionSheet = UIAlertController(title: "Filter", message: "", preferredStyle: .actionSheet)
        let sortByNameAction = UIAlertAction(title: "Sort by Name", style: .default) { action in
            self.interactor.sortRestaurantsByName(self.restaurants)
        }
        let sortByRateAction = UIAlertAction(title: "Sort By Rate", style: .default) { action in
            self.interactor.sortRestaurantsByRate(self.restaurants)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        sortActionSheet.addAction(sortByNameAction)
        sortActionSheet.addAction(sortByRateAction)
        sortActionSheet.addAction(cancelAction)
        self.present(sortActionSheet, animated: true)
    }
    
    func favorite(_ restaurant: Restaurant) {
        Task {
            await self.interactor.saveOrRemoveAsFavorite(restaurant)
        }
    }
}
