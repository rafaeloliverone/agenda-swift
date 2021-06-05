//
//  TableViewController.swift
//  project_bd
//
//  Created by IFPB on 05/06/21.
//  Copyright © 2021 IFPB. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var lista: Array<Pessoas>!
    
    @IBAction func search(_ sender: Any) {
        
        let search = UIAlertController(title: "Filtro", message: "Filtro por nome", preferredStyle: UIAlertController.Style.alert)
        search.addTextField { textField in
            textField.placeholder = "Digite um nome"
        }
        search.addAction(UIAlertAction(title: "Pesquisar", style: UIAlertAction.Style.default, handler: { alertAction in
            let searchName = search.textFields![0].text!
            print(searchName)
            if (searchName != "") {
                self.lista = PessoaDAO().byName(name: searchName)
                self.tableView.reloadData()
            }
        }))
        
        search.addAction(
            UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil)
        )
        
        search.addAction(UIAlertAction(title: "Exibir Todas", style: UIAlertAction.Style.cancel, handler: { alertAction in
            self.lista = PessoaDAO().get()
            self.tableView.reloadData()
        }))
        
        self.present(search, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.lista = PessoaDAO().get()        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.lista = PessoaDAO().get()
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.lista.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        // Configure the cell...
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "pessoas", for: indexPath)

        let pessoa = self.lista[indexPath.row]
               
        cell.textLabel?.text = pessoa.name
        cell.detailTextLabel?.text = String(pessoa.idade)

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let pessoa = self.lista[indexPath.row]
            PessoaDAO().del(pessoa: pessoa)
            self.lista.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let fvc = self.storyboard?.instantiateViewController(identifier: "formulario") as! ViewController
            fvc.pessoaEditavel = self.lista[indexPath.row]
            self.navigationController?.pushViewController(fvc, animated: true)
    }
    

}
