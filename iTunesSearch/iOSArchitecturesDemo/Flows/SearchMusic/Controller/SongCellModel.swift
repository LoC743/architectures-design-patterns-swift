//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Alexey on 11.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let trackName: String?
    let artistName: String?
    let artworkURL: String?
}

final class SongCellModelFactory {
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(
            trackName: model.trackName,
            artistName: model.artistName,
            artworkURL: model.artwork
        )
    }
}
