//
//  DataManager.swift
//  Gaga
//
//  Created by Jan Zelaznog on 20/05/22.
//

import Foundation

class DataManager: NSObject {
    
    static let instance = DataManager()
    
    override private init() {
        super.init()
        getInfo()
    }
    
    let baseURL = "http://janzelaznog.com/DDAM/iOS/gaga"
    var info = [[String : String]]()
    
    func getInfo() {
        /* TÉCNICA BÁSICA:  1) obtener la URL del recurso
                            2) obtener el contenido del recurso en forma de arreglo de bytes
                                a. se puede obtener directamente (main thread)
                                b. se implementa una tarea con la clase URLSession
        */
         if let url = URL(string: baseURL + "/info.json") {
             do {
                 let bytes = try Data(contentsOf: url)
                 let tmp = try JSONSerialization.jsonObject(with: bytes, options: .allowFragments)
                 self.info = tmp as! [[String:String]]
                 print (self.info)
             }
             catch {
                 print ("ocurrio un error \(error.localizedDescription)")
             }
        }
    }
}
