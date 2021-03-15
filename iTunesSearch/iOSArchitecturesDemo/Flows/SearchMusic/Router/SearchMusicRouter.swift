//
//  SearchMusicRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Alexey on 15.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchMusicRouterInput {
    func openSongPlayer(for song: ITunesSong)
    func openSongInITunes(song: ITunesSong)
    func moveToAppSearch()
}

class SearchMusicRouter: SearchMusicRouterInput {
    weak var viewController: UIViewController?
    
    func openSongPlayer(for song: ITunesSong) {
        print("\(#function) not implemented")
//        let playerViewController =
//        viewController?.present(playerViewController, animated: true, completion: nil)
    }
    
    func openSongInITunes(song: ITunesSong) {
        guard let urlString = song.trackUrl,
              let URL = URL(string: urlString) else { return }
        
        UIApplication.shared.open(URL, options: [:], completionHandler: nil)
    }
    
    func moveToAppSearch() {
        ScreenManager.shared.openAppSearch()
    }
}
