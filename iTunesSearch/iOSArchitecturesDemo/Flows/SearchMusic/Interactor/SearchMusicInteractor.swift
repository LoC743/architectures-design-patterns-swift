//
//  SearchMusicInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Alexey on 15.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Alamofire

protocol SearchMusicInteractorInput {
    func requestSongs(with querry: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}

class SearchMusicInteractor: SearchMusicInteractorInput {
    private let searchService = ITunesSearchService()
    
    func requestSongs(with querry: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        searchService.getSongs(forQuery: querry, completion: completion)
    }
}
