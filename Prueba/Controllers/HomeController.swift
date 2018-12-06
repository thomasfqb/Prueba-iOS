//
//  HomeController.swift
//  Prueba
//
//  Created by Thomas Fauquemberg on 06/12/2018.
//  Copyright © 2018 Thomas Fauquemberg. All rights reserved.
//

import UIKit

var isLoggedIn = false

class HomeController: UITableViewController {
    
    let cellId = "cellId"
    var movies = [MovieViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = false
        
        setupContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfUserIsLoggedIn()
    }
    
    fileprivate func checkIfUserIsLoggedIn() {
        if !isLoggedIn {
            let loginController = LoginController()
            self.present(loginController, animated: true, completion: nil)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieTableViewCell
        cell.movieViewModel = movies[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Marvel movies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc fileprivate func handleLogout() {
        isLoggedIn = false
        checkIfUserIsLoggedIn()
    }
    
    fileprivate func setupContent() {
        
        let movie1 = MovieViewModel(title: "Guardians of the Galaxy",
                                    description: "Light years from Earth, 26 years after being abducted, Peter Quill finds himself the prime target of a manhunt after discovering an orb wanted by Ronan the Accuser.",
                                    imageName: "guardians")
        movies.append(movie1)
        let movie2 = MovieViewModel(title: "Guardians of the Galaxy vol. 2",
                                    description: "The Guardians must fight to keep their newfound family together as they unravel the mysteries of Peter Quill's true parentage.",
                                    imageName: "guardians2")
        movies.append(movie2)
        
        let movie3 = MovieViewModel(title: "The Avengers",
                                    description: "When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!",
                                    imageName: "avengers")
        movies.append(movie3)
        
        let movie4 = MovieViewModel(title: "Deadpool",
                                    description: "Deadpool tells the origin story of former Special Forces operative turned mercenary Wade Wilson, who after being subjected to a rogue experiment that leaves him with accelerated healing powers, adopts the alter ego Deadpool. Armed with his new abilities and a dark, twisted sense of humor, Deadpool hunts down the man who nearly destroyed his life.",
                                    imageName: "deadpool")
        movies.append(movie4)
        
        let movie5 = MovieViewModel(title: "Iron man",
                                    description: "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.",
                                    imageName: "ironman")
        movies.append(movie5)
        
        let movie6 = MovieViewModel(title: "Spider-Man: Homecoming",
                                    description: "Following the events of Captain America: Civil War, Peter Parker, with the help of his mentor Tony Stark, tries to balance his life as an ordinary high school student in Queens, New York City, with fighting crime as his superhero alter ego Spider-Man as a new threat, the Vulture, emerges.",
                                    imageName: "spiderman")
        movies.append(movie6)
        
        let movie7 = MovieViewModel(title: "Avengers: Age of Ultron",
                                    description: "When Tony Stark tries to jumpstart a dormant peacekeeping program, things go awry and Earth’s Mightiest Heroes are put to the ultimate test as the fate of the planet hangs in the balance. As the villainous Ultron emerges, it is up to The Avengers to stop him from enacting his terrible plans, and soon uneasy alliances and unexpected action pave the way for an epic and unique global adventure.",
                                    imageName: "avengers2")
        movies.append(movie7)
        
    }
    
}
