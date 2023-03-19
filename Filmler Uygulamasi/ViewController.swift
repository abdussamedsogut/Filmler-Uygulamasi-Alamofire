//
//  ViewController.swift
//  Filmler Uygulamasi
//
//  Created by Abdüssamed Söğüt on 26.02.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    
    @IBOutlet weak var kategoriTableView: UITableView!
    
    var kategoriListe = [Kategoriler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let k1 = Kategoriler(kategori_id: 1, kategori_ad: "Dram")
        let k2 = Kategoriler(kategori_id: 2, kategori_ad: "Komedi")
        let k3 = Kategoriler(kategori_id: 3, kategori_ad: "Bilim Kurgu")
        kategoriListe.append(k1)
        kategoriListe.append(k2)
        kategoriListe.append(k3)

        kategoriTableView.dataSource = self
        kategoriTableView.delegate = self
        
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategoriListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriHucre", for: indexPath) as! KategoriHucreTableViewCell
        
        cell.labelKategoriAd.text = kategoriListe[indexPath.row].kategori_ad
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toFilm", sender: indexPath.row)
        
    }
    
}
