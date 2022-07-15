//
//  ViewController.swift
//  NewsApp
//
//  Created by Pantos, Thomas on 7/7/22.
//

import UIKit
import SafariServices
import AVFoundation
import FirebaseAuth
//tableView
//customCall
// open news story
// search
class MainController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var main: UIView!
    
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)


//        let utterance = AVSpeechUtterance(string: "Γεια σου θωμά")
//        utterance.voice = AVSpeechSynthesisVoice(language: "gr-GR")
//        utterance.rate  = 0.1
//        let  synthesizer = AVSpeechSynthesizer()
//        synthesizer.speak(utterance)
        
        title = "News"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        APICaller.shared.getTopstories{[weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title,
                                               subtitle: $0.description ?? "No desc",
                                               imageURL: URL(string: $0.urlToImage ?? ""),
                                               url: $0.url )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    @IBAction func pressedLogout(_ sender: Any) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
 
   
    func tableView( _ tableVIew: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard  let cell = tableVIew.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath)
        as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = viewModels[indexPath.row]
        print(article.url)
        guard let url = URL(string: article.url ) else { return }
        

        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
    }
}

