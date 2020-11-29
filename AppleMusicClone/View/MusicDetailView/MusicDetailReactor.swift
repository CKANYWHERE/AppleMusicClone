//
//  MusicDetailReactor.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/28.
//

import Foundation
import AVFoundation
import ReactorKit
import RxCocoa

class MusicDetailReactor:Reactor{
   
    let initialState: State = State()
    private let player = AVPlayer()
    
     enum Action {
        case loadMusic(AVPlayerItem?)
     }
     
     enum Mutation {
         case setMusic(AVPlayerItem?)
     }
     
    struct State {
        var music:AVPlayerItem? = nil
     }
     
     func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadMusic(let item):
            return Observable.just(Mutation.setMusic(item))
        }
     }
       
     func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        
        case let .setMusic(music):
            newState.music = music
        }
        
        return newState
     }

}
