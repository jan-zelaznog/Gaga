//
//  LoginViewController.swift
//  Gaga
//
//  Created by Jan Zelaznog on 20/05/22.
//

import UIKit

class LoginViewController: UIViewController {
    var a_i = UIActivityIndicatorView()
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    @IBAction func btnEntrarTouch (_ sender: Any) {
        // TODO: Agregar validaciones a los campos
        a_i.startAnimating()
        // Autenticación contra un Backend. Usando la clase nativa URLSession
        if let url = URL(string:"http://janzelaznog.com/DDAM/iOS/WS/login.php") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let params = "username=\(self.txtUser.text!)&password=\(self.txtPass.text!)"
            request.httpBody = params.data(using: .utf8)
            let sesion = URLSession.shared
            let tarea = sesion.dataTask(with: request) { bytes, response, error in
                if error != nil {
                    print ("ocurrio un error \(error!.localizedDescription)")
                }
                else {
                    var message = ""
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: bytes!, options: .allowFragments) as? [String:Any] {
                            if (dict["code"] as? String ?? "") == "200" {
                                DispatchQueue.main.async {
                                    self.a_i.stopAnimating()
                                    self.performSegue(withIdentifier: "goHome", sender: nil)
                                }
                            }
                            else {
                                message = dict["message"] as? String ?? "Response error"
                            }
                        }
                    }
                    catch {
                        message = "error al convertir a JSON \(error.localizedDescription)"
                    }
                    DispatchQueue.main.async {
                        self.a_i.stopAnimating()
                        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            tarea.resume()
        }
        /* Autenticación LOCAL
        var message = ""
        if let url = Bundle.main.url(forResource: "USER_DATA", withExtension: "json") {
          do {
            let bytes = try Data.init(contentsOf: url)
            let jsonArray = try JSONSerialization.jsonObject(with:bytes, options:.mutableContainers) as! [[String:Any]]
              // HOF
            let filteredArray = jsonArray.filter{
              dictionary in
              return dictionary["user_name"] as! String == self.txtUser.text!
            }
            if filteredArray.count == 0 {
              message = "El usuario no existe"
            }
            else {
              let userInfo = filteredArray.first!
              if (userInfo["password"] as! String) != self.txtPass.text! {
                message = "El password no coincide"
              }
            }
          }
          catch {
            
          }
        }
        if message == "" {
            // avanza al home
            self.performSegue(withIdentifier: "goHome", sender: nil)
        }
        else {
            let alert = UIAlertController(title: "", message:message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        a_i.style = .large
        a_i.color = .red
        a_i.hidesWhenStopped = true
        a_i.center = self.view.center
        self.view.addSubview(a_i)
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
