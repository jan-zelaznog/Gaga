//
//  PictViewController.swift
//  Gaga
//
//  Created by Jan Zelaznog on 20/05/22.
//

import UIKit

class PictViewController: UIViewController {
    var item:Item?
    var imageView = UIImageView()
    var a_i = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = self.view.frame.insetBy(dx: 20, dy: 20)
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        a_i.style = .large
        a_i.color = .red
        a_i.hidesWhenStopped = true
        a_i.center = self.view.center
        self.view.addSubview(a_i)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let lItem = self.item else { return }
        // Obtener la imagen que se va a mostrar
        /* TÉCNICA BÁSICA:  1) obtener la URL del recurso
                            2) obtener el contenido del recurso en forma de arreglo de bytes
                                a. se puede obtener directamente (main thread)
                                b. se implementa una tarea con la clase URLSession
        */
        // comprobar si existe la imagen local
        
        
        // TODO: Implementa la descarga con URLSession
        // TODO: Validar la conexión a Internet...
        if let url = URL(string:DataManager.instance.baseURL + "/" + lItem.pict) {
            let request = URLRequest(url: url)
            let sesion = URLSession.shared
            let tarea = sesion.dataTask(with: request) { bytes, response, error in
                if error != nil {
                    print ("ocurrio un error \(error!.localizedDescription)")
                }
                else {
                    let image = UIImage(data: bytes!)
                    self.guardaImagen(bytes!, lItem.pict)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.a_i.stopAnimating()
                    }
                }
            }
            a_i.startAnimating()
            tarea.resume()
            /* ESTO ES PARA DESCARGAR DIRECTAMENTE
             do {
                 let bytes = try Data(contentsOf: url)
                 let image = UIImage(data: bytes)
                 self.imageView.image = image
             }
             catch {
                 print ("ocurrio un error \(error.localizedDescription)")
             }*/
        }
    }
    
    func cargaImagenLocal (_ nombre:String) -> Bool {
        // 1. Obtener la ruta a documents
        
        // 2. comprobar si existe el archivo
        // 2.a. el objeto URL tiene una propiedad path....
        // FileManager.default.fileExists(atPath: <#T##String#>) regresa true o false
        
        // 3. si el archivo existe, lo cargamos en el imageview y se regresa true
        
        // 4. si el archivo no existe se regresa false.
    }
    
    func guardaImagen(_ bytes:Data, _ nombre:String) {
        // 1. Obtenemos la ubicacion de la carpeta de documents
        let urlAdocs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let urlAlArchivo = urlAdocs.appendingPathComponent(nombre)
        do {
            try bytes.write(to: urlAlArchivo)
        }
        catch {
            print ("no se puede salvar la imagen \(error.localizedDescription)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
