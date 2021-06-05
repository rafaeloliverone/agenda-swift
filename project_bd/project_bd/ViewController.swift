//
//  ViewController.swift
//  project_bd
//
//  Created by IFPB on 05/06/21.
//  Copyright © 2021 IFPB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tfNome: UITextField!
    
    @IBOutlet weak var tfIdade: UITextField!
    var pessoaEditavel: Pessoas!
    
    
    @IBAction func save(_ sender: Any) {
        let name = self.tfNome.text
        let year = Int16(self.tfIdade.text!)
        
        if (self.pessoaEditavel != nil){
            self.pessoaEditavel.name = name
            self.pessoaEditavel.idade = year!
            PessoaDAO().update()
        } else {
            PessoaDAO().add(nome: name!, idade: year!)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.pessoaEditavel != nil){
            self.tfNome.text = self.pessoaEditavel.name
            self.tfIdade.text = String(self.pessoaEditavel.idade)
        }    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

