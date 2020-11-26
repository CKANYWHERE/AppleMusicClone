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

    private func loadAlbum() -> [AlbumSection]{
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        let tracks = urls.map { AVPlayerItem(url: $0) }
        let trackList = tracks.compactMap { $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList, by: { track in  track.albumName })
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            print(title)
            albums.append(album)
        }
        let albumSection = AlbumSection(header: "Today's Pick", items: albums)
        let sectionData = [albumSection]
        return sectionData
    }
    
    private func loadTracks() -> [TrackSection] {
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        let tracks = urls.map { AVPlayerItem(url: $0) }
        let trackList = tracks.compactMap { $0.convertToTrack() }
        let trackSection = TrackSection(header: "Today's Pick", items: trackList)
        let sectionData = [trackSection]
        return sectionData
    }
}
