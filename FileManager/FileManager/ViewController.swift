//
//  ViewController.swift
//  FileManager
//
//  Created by DCS on 09/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var notesArray = [String]()
    private let notestbl = UITableView()
    var del = ""
    // make instance
    let service = DataService()
    
    
    @objc private func logoutFunc(){
        
        UserDefaults.standard.setValue(nil, forKey: "sessionToken")
        checkAuth()
    }
    
    // extract notes from directory
    private func fetchNotes(){
        
        
        
        let path = service.getDocDir()
        do{
            let item = try FileManager.default.contentsOfDirectory(at : path, includingPropertiesForKeys: nil)
            notesArray.removeAll()
            for i in item{
                notesArray.append(i.lastPathComponent)
            }
        }catch{
            print(error)
        }
        
        
        notestbl.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchNotes()
        checkAuth()
        
    }
    private func checkAuth(){
        
        if let token = UserDefaults.standard.string(forKey: "sessionToken"),
            let name = UserDefaults.standard.string(forKey: "username")
        {
            print("token :: \(name) | \(token)")
            
        }
        else{
            let vc = LoginVc()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        notestbl.frame = view.bounds
    }
    // create document directory
    
    
    @objc private func openNotes(){
        let vc = NewNotesvc()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        print(service.getDocDir())
        view.addSubview(notestbl)
        let additem1 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutFunc))
        navigationItem.setRightBarButton(additem1, animated: true)
        let additem2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNotes))
        navigationItem.setLeftBarButton(additem2, animated: true)
        
        
        setuptbl()
        fetchNotes()
        // Do any additional setup after loading the view.
    }}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    private func setuptbl(){
        
        notestbl.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        notestbl.delegate = self
        notestbl.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for : indexPath)
        cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //let del = notesArray[indexPath.row]
        if editingStyle == .delete{
            notestbl.beginUpdates()
            _ =  notesArray.remove(at: indexPath.row)
            notestbl.deleteRows(at: [indexPath], with: .fade)
            
            //service.getDocDir().deletingLastPathComponent("\(name).txt")
            
            
            
            notestbl.reloadData()
            notestbl.endUpdates()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewNotesvc()
        vc.updatefile = notesArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

