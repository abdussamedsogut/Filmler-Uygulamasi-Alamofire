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
        
        kategoriTableView.dataSource = self
        kategoriTableView.delegate = self
        
        tumKategorilerAl()
    }


    func tumKategorilerAl() {
        AF.request("http://kasimadalan.pe.hu/filmler/tum_kategoriler.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(KategoriCevap.self, from: data)
                   
                    if let gelenKategoriListesi = cevap.kategoriler {
                        self.kategoriListe = gelenKategoriListesi
                    }
                    DispatchQueue.main.async {
                        self.kategoriTableView.reloadData()
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let gidilecekVC = segue.destination as! FilmViewController
        gidilecekVC.kategori = kategoriListe[indeks!]
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
