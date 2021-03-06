//
//  AppDetailDescriptionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alexey on 11.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailDescriptionViewController: UIViewController {
    private let app: ITunesApp
    
    private var appDetailDescriptionView: AppDetailDescriptionView {
        return self.view as! AppDetailDescriptionView
    }
    
    init(app: ITunesApp) {
        self.app = app

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailDescriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        congureUI()
    }
    
    private func congureUI() {
        appDetailDescriptionView.versionLabel.text = "Version \(app.version ?? "")"
        let versionDate: String = DateFormatter.shared.string(from: app.currentVersionReleaseDate ?? Date())
        appDetailDescriptionView.versionDateLabel.text = "\(versionDate)"
        appDetailDescriptionView.setReleaseNoteText(with: app.releaseNotes ?? "")
    }
    
}
