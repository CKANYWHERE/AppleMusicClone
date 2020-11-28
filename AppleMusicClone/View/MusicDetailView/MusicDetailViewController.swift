//
//  MusicDetailViewController.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/28.
//

import UIKit
import AVFoundation
import ReactorKit
import RxCocoa

class MusicDetailViewController:UIViewController, ReactorKit.View{
    
    var disposeBag: DisposeBag = DisposeBag()
    let reactor : MusicDetailReactor = MusicDetailReactor()
    var music: AVPlayerItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          view.backgroundColor = .white
          
          setupUI()
          bind(reactor: reactor)
      }
    
    private func setupUI(){
        
    }
    
    func bind(reactor:MusicDetailReactor){
        let firstLoad = rx.viewWillAppear
            .map { _ in () }
        
        Observable.merge(firstLoad)
            .map{ [weak self] in Reactor.Action.loadMusic(self?.music)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map{$0.music}
            .subscribe{ state in
                print(state.element?.value?.convertToTrack()!)
            }.disposed(by: disposeBag)
        
    }
    
}
