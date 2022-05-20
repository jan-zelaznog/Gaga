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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.frame = self.view.frame.insetBy(dx: 20, dy: 20)
        self.view.addSubview(imageView)
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
        if let url = URL(string:DataManager.instance.baseURL + "/" + lItem.pict) {
             do {
                 let bytes = try Data(contentsOf: url)
                 let image = UIImage(data: bytes)
                 self.imageView.image = image
             }
             catch {
                 print ("ocurrio un error \(error.localizedDescription)")
             }
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
