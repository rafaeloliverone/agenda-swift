

import Foundation
import UIKit
import CoreData

class PessoaDAO {
    var delegate: AppDelegate!
    
    init() {
        self.delegate = (UIApplication.shared.delegate as! AppDelegate)
    }
    
    func add(nome: String, idade: Int16) {
        let pessoa = Pessoas(context: self.delegate.persistentContainer.viewContext)
        pessoa.name = nome
        pessoa.idade = idade
        self.delegate.saveContext()
    }
    
    func get() -> Array<Pessoas> {
        let requisicao:NSFetchRequest<Pessoas> = Pessoas.fetchRequest()
        do {
            let pessoas = try self.delegate.persistentContainer.viewContext.fetch(requisicao)
            return pessoas
        } catch {
            return Array<Pessoas>()
        }
    }
    
    func del(pessoa: Pessoas){
        self.delegate.persistentContainer.viewContext.delete(pessoa)
        self.delegate.saveContext()
    }
    
    func update(){
        self.delegate.saveContext()
    }
    
    func byName(name: String) -> Array<Pessoas> {
        let requisicao:NSFetchRequest<Pessoas> = Pessoas.fetchRequest()
        requisicao.predicate = NSPredicate(format: "name CONTAINS %@", name)
        do {
            let pessoas = try self.delegate.persistentContainer.viewContext.fetch(requisicao)
            return pessoas
        } catch {
            return Array<Pessoas>()
        }
        
    }
}
