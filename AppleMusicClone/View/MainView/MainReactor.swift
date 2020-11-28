//
//  MainReactor.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/25.
//

import Foundation
import AVFoundation
import ReactorKit
import RxCocoa

class MainReactor: Reactor {
   
    let initialState: State = State()
    
    enum Action {
        case loadAlbum
    }
    
    enum Mutation {
        case setAlbum([TrackSection])
    }
    
    struct State {
        var albums:[TrackSection] = []
    }
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .loadAlbum:
            return Observable.just(Mutation.setAlbum(loadTracks()))
        }
    }
      
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setAlbum(albums):
            newState.albums = albums
        }
        return newState
    }
    
    private func loadTracks() -> [TrackSection] {
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        let tracks = urls.map { AVPlayerItem(url: $0) }
        let trackSection = TrackSection(header: "Today's Pick", items: tracks)
        let sectionData = [trackSection]
        return sectionData
    }
}
