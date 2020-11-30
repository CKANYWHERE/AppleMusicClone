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
    
     enum Action {
        case loadMusic(AVPlayerItem?)
        case play
     }
     
     enum Mutation {
        case setMusic(AVPlayerItem?)
        case playValue
     }
     
    struct State {
        var music:AVPlayerItem? = nil
        var isPlaying = false
     }
     
     func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadMusic(let item):
            return Observable.just(Mutation.setMusic(item))
        case .play:
            return Observable.just(Mutation.playValue)
        }
     }
       
     func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setMusic(music):
            newState.music = music
        case .playValue:
            if state.isPlaying == false{
                newState.isPlaying = true
            }else{
                newState.isPlaying = false
            }
               
        }
        
        return newState
     }

}
