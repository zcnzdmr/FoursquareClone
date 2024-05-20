//
//  HomePage.swift
//  FoursquareClone
//
//  Created by Özcan on 20.05.2024.
//

import UIKit

class HomePage: UIViewController {
    
    var tableViewm = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableSetUp()
        barButton()
    }
    
    // MARK: BarButtonItem Kısmı
    private func barButton() {
        
        let add = UIBarButtonItem(image: UIImage(systemName: "plus.square"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(passToAddPage))
        add.tintColor = .black
//        add.width = 30
        self.navigationItem.rightBarButtonItem = add
        
    }
    
    @objc func passToAddPage() {
        self.show(RegisterPage(), sender: nil)
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
}

extension HomePage : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hucrem", for: indexPath) as! HomeCell
        
        
        return cell
    }
}
