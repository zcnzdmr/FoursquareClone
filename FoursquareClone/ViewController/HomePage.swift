//
//  HomePage.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomePage: UIViewController {
    
    var tableViewm     = UITableView()
    var nameArray      = [String]()
    var typeArray      = [String]()
    var commentArray   = [String]()
    var urlArray       = [String]()
    var latitudeArray  = [Double]()
    var longitudeArray = [Double]()
    var documentArray  = [String]()
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont(name: "Papyrus", size: 20)!]
        
        self.navigationItem.title = "HomePage"
        
        tableSetUp()
        barButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    // MARK: BarButtonItem Kısmı
    private func barButton() {
        
//        let logOut = UIBarButtonItem()
//        logOut.tintColor = .black
//        self.navigationItem.backBarButtonItem = logOut
        
        self.navigationItem.backButtonTitle = "Back"
        
        let logOut = UIBarButtonItem(image: UIImage(systemName: "person.slash"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(logOutFonk))
        logOut.tintColor = .black
        self.navigationItem.leftBarButtonItem = logOut
        
        let add = UIBarButtonItem(image: UIImage(systemName: "plus.square"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(passToAddPage))
        add.tintColor = .black
//        add.width = 30
        self.navigationItem.rightBarButtonItem = add
        
    }
    
    // MARK: RegisterPage'e götüren fonk.
    @objc func passToAddPage() {
        self.show(RegisterPage(), sender: nil)
    }
    
    @objc func logOutFonk() {
        do {
            try Auth.auth().signOut()
            HomePage().modalPresentationStyle = .fullScreen
            self.present(SignInPage(), animated: true)
//            self.navigationController?.pushViewController(SignInPage(), animated: true)
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    // MARK: tableView Kurulum kısmı
    func tableSetUp() {
        
        tableViewm.frame = view.bounds
        tableViewm.dataSource = self
        tableViewm.delegate = self
        tableViewm.register(HomeCell.self, forCellReuseIdentifier: "hucrem")
        tableViewm.layer.backgroundColor = UIColor.orange.cgColor
        tableViewm.rowHeight = 40
        view.addSubview(tableViewm)
    }
    
    // MARK: FireStore'dan veri çekilen kısım
    func getData() {
        
        db.collection("Places").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                self.alert(title: "Error", message: error?.localizedDescription ?? "error getting data from FireStore")
            }else{
                if snapshot?.isEmpty == false {
                    
                    
                    self.documentArray.removeAll()
                    self.nameArray.removeAll()
                    self.typeArray.removeAll()
                    self.commentArray.removeAll()
                    self.urlArray.removeAll()
                    
                    for document in snapshot!.documents {
                        
                        
                        let documentID = document.documentID
                        self.documentArray.append(documentID)
                        
                        
                        if let nameOfPlace = document.get("nameOfPlace") as? String {
                            self.nameArray.append(nameOfPlace)
                        }
                        
                        if let typeOfPlace = document.get("typeOfPlace") as? String {
                            self.typeArray.append(typeOfPlace)
                        }
                        
                        if let comment = document.get("comment") as? String {
                            self.commentArray.append(comment)
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.urlArray.append(imageUrl)
                        }
                        
                        if let latitude = document.get("latitude") as? Double {
                            self.latitudeArray.append(latitude)
                        }
                        
                        if let longitude = document.get("longitude") as? Double {
                            self.longitudeArray.append(longitude)
                        }
                        
                    }
                        self.tableViewm.reloadData()
                }
            }
        }
        
    }
    
    // MARK: DetailPage'e yönlendiren fonk
    func passToDetail(nameArrayx:String,typeArrayx: String,commentArrayx : String,urlArrayx : String, latitudex : Double, longitudex : Double) {
        self.navigationController?.pushViewController(DetailPage(nameArray    : nameArrayx,
                                                                 typeArray    : typeArrayx,
                                                                 commentArray : commentArrayx,
                                                                 urlArray     : urlArrayx,
                                                                 latitude     : latitudex,
                                                                 longitude    : longitudex), animated: true)
    }
    
    // MARK: Alert oluşturma kısmı
    func alert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okAction)
        self.present(alert,animated: true)
        
    }
}




extension HomePage : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucrem", for: indexPath) as! HomeCell
        
        cell.label1.text = nameArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let name = nameArray[indexPath.row]
        let type = typeArray[indexPath.row]
        let comment = commentArray[indexPath.row]
        let url = urlArray[indexPath.row]
        let latitudey = latitudeArray[indexPath.row]
        let longitudey = longitudeArray[indexPath.row]
        
        passToDetail(nameArrayx: name, typeArrayx: type, commentArrayx: comment, urlArrayx: url ,latitudex: latitudey, longitudex: longitudey)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: UIContextualAction.Style.destructive, title: "Delete") { contextualaction, view , bool in
            
            let alert2 = UIAlertController(title: "Delete", message: "\(self.nameArray[indexPath.row]) is gonna deleted ?", preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { alertaction in
                
                self.db.collection("Places").document("\(self.documentArray[indexPath.row])").delete()
                print("Document successfully removed!")
            }
            alert2.addAction(yes)
            
            let no = UIAlertAction(title: "No", style: UIAlertAction.Style.destructive)
            alert2.addAction(no)
            
            self.present(alert2, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

}
