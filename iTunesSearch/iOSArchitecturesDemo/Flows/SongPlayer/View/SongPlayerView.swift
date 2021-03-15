//
//  SongPlayerView.swift
//  iOSArchitecturesDemo
//
//  Created by Alexey on 15.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongPlayerView: UIView {
    private(set) lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private(set) lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private(set) lazy var singerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .varna
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private(set) lazy var playerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [playButton, stopButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private(set) lazy var playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "play")
        button.tintColor = .black
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private(set) lazy var stopButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "stop")
        button.tintColor = .black
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        self.addSubview(songImageView)
        self.addSubview(songNameLabel)
        self.addSubview(singerLabel)
        self.addSubview(playerStackView)
        
        let sideOffset: CGFloat = 100
        let imageViewSquare = UIScreen.main.bounds.width - sideOffset
        
        NSLayoutConstraint.activate([
            songImageView.topAnchor.constraint(equalTo: topAnchor, constant: sideOffset),
            songImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            songImageView.heightAnchor.constraint(equalToConstant: imageViewSquare),
            songImageView.widthAnchor.constraint(equalToConstant: imageViewSquare),
            
            songNameLabel.topAnchor.constraint(equalTo: songImageView.bottomAnchor, constant: 50),
            songNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            songNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            singerLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 7),
            singerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            singerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            playerStackView.topAnchor.constraint(equalTo: singerLabel.bottomAnchor, constant: 10),
            playerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func changePlayButton(to state: PlayerState) {
        switch state {
        case .paused:
            playButton.setImage(UIImage(named: "play"), for: .normal)
        case .playing:
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        case .stopped:
            playButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
}
