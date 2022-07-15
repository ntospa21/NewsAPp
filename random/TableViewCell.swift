//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Pantos, Thomas on 7/7/22.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    var url : String
    init(title: String, subtitle: String, imageURL: URL?, url: String){
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.url = url
    }
}

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let subtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private let newsImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitle)
        contentView.addSubview(newsImageView)
        
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTitleLabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width - 120 , height: 70)
        subtitle.frame = CGRect(x: 10, y: 70, width: contentView.frame.size.width - 150 , height: contentView.frame.size.height/2)
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 170, y: 5, width: 160 , height: contentView.frame.size.height - 10)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitle.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel ){
        newsTitleLabel.text = viewModel.title
        subtitle.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else  if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url){data, _ , error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
            
        }
    }
}
