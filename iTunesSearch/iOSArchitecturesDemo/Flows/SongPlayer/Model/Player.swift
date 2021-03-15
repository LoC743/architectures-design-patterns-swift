//
//  Player.swift
//  iOSArchitecturesDemo
//
//  Created by Alexey on 15.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import AVFoundation
import RxCocoa

enum PlayerState {
    case playing
    case paused
    case stopped
}

final class Player: NSObject {
    private var player: AVAudioPlayer?
    
    public lazy var state: BehaviorRelay<PlayerState> = {
        return BehaviorRelay(value: currentState)
    }()
    
    private var currentState: PlayerState = .stopped {
        didSet {
            state.accept(currentState)
        }
    }
    
    func play(with URL: URL) {
        do {
            self.player = try AVAudioPlayer(contentsOf: URL)
            player?.delegate = self
            player?.prepareToPlay()
            player?.volume = 1.0
            player?.play()
            currentState = .playing
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pause() {
        player?.pause()
        currentState = .paused
    }
    
    func resume() {
        player?.play()
        currentState = .playing
    }
    
    func stop() {
        player?.stop()
        currentState = .stopped
        player = nil
    }
}

extension Player: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        currentState = .stopped
    }
}
