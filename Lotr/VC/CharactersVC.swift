//
//  CharactersVC.swift
//  Lotr
//
//  Created by Natalija Krsnik on 03/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//


// Some info for the characters taken from https:// en.wikipedia.org/wiki/Category:The_Lord_of_the_Rings_characters
import UIKit

class CharactersVC: UIViewController, UITableViewDelegate {

    var tblCharacters: UITableView = UITableView()
    var safeArea: UILayoutGuide = UILayoutGuide()
    var characters = [Characters]()
    var filteredCharacters = [Characters]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
         //sets image and blur effect
        ReusableFunctions.shared.setTheme(view: self.view)
       
         //nav text color and font
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.txtColorYellow, NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20)!]
        
        safeArea = view.layoutMarginsGuide
        tblCharacters.delegate = self
        
        setupTable()
        getData{
            self.tblCharacters.reloadData()
        }
        setupSearchController()
        
        //title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController!.navigationBar.sizeToFit()
        navigationController!.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    /**
     Sets constraints for table
     */
    func setupTable(){
        view.addSubview(tblCharacters)
        
        tblCharacters.backgroundColor = .clear
        tblCharacters.translatesAutoresizingMaskIntoConstraints = false
        tblCharacters.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tblCharacters.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tblCharacters.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tblCharacters.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    /**
     Fetching data from json and append it to characters array.
     - Registering the cell CharactersCell, so it can be used.
     */
    func getData(completed: @escaping () -> ()){
        
        tblCharacters.register(CharactersCell.self, forCellReuseIdentifier: "charactersCell")
        tblCharacters.dataSource = self
        
        if let localJSONdata = ReusableFunctions.shared.readLocalJSONFile(name: "characters"){
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(Root.self, from: localJSONdata)
                result.character.forEach { element in
                    characters.append(element)
                }
                DispatchQueue.main.async {
                    completed()
                }
                
            } catch {
                print(error)
            }
        }
        
        //do not display extra empty cells: empty rows are not displayed when the table has a footer view below the table cells
        tblCharacters.tableFooterView = UIView()
    }
   
    func filterContentForSearchText(_ searchText: String) {
        filteredCharacters = characters.filter { (characters: Characters) -> Bool in
            return characters.name!.lowercased().contains(searchText.lowercased())
        }
        tblCharacters.reloadData()
    }
}

extension CharactersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { return filteredCharacters.count }
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersCell", for: indexPath) as! CharactersCell
        
        // if user filters array
        if isFiltering {
            cell.nameLabel.text = filteredCharacters[indexPath.item].name
            cell.lastnameLabel.text = filteredCharacters[indexPath.item].lastname
            
            if let savedImage = retrieveImg(forKey: (self.filteredCharacters[indexPath.item].name)!,
                                            inStorageType: .fileSystem) {
                cell.characterImage.image = savedImage
                
            }else{
                    cell.characterImage.image = UIImage(named: "lotr_eye")
            }
            
        }else{
            cell.nameLabel.text = characters[indexPath.item].name
            cell.lastnameLabel.text = characters[indexPath.item].lastname
            
            let savedImage = retrieveImg(forKey: (self.characters[indexPath.item].name)!,
                                         inStorageType: .fileSystem)
            //check if image exist localy, return
            if savedImage != nil {
                DispatchQueue.main.async {
                    cell.characterImage.image = savedImage
                }
                //else get it from url using URLSession
            }else {
                if self.characters[indexPath.item].urlToimage != "" {
                    //create url
                    let url = URL(string:(self.characters[indexPath.item].urlToimage)!)
                    //fetch data with URLSession
                    let d = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                        if error != nil {
                            print("Error:", error as Any)
                            return
                        }
                        
                        guard let httpResponse = response as? HTTPURLResponse,
                              (200...299).contains(httpResponse.statusCode) else {
                            print("Response error:", response!)
                            return
                        }
                        
                        if let data = data {
                            if self.characters[indexPath.item].name != "" {
                                store(image: UIImage(data: data)!,
                                      forKey: self.characters[indexPath.item].name!,
                                      withStorageType: .fileSystem)
                            }
                            DispatchQueue.main.async {
                                cell.characterImage.image = UIImage(data: data)
                            }
                        }
                    }
                    d.resume()
                }else{
                    DispatchQueue.main.async {
                        cell.characterImage.image = UIImage(named: "circle")
                        cell.characterImage.tintColor = .black
                    }
                }
            }
        }
        return cell
    }

    /**
        If user selects a cell, data about the character (name, lastname, kind, side, weapon...) will be passed via pushViewController
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var char = characters[indexPath.item]
        let vc = CharacterInfoVC()
        
        if isFiltering {
            char = filteredCharacters[indexPath.item]
        }
        
        vc.characterInfo = char
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    /**
         Function that sets search bar placeholder, tint color ...
     */
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Searching for..."
        searchController.searchBar.tintColor = UIColor.yellow
        searchController.searchBar.barStyle = .black
        searchController.hidesNavigationBarDuringPresentation = true

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension CharactersVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
