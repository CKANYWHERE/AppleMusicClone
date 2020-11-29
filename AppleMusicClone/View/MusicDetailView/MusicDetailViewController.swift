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
    
    lazy var lblSong = UILabel().then{
        $0.text = "Today's Pick"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 27)
        $0.textAlignment = .center
    }
    
    lazy var lblAuthor = UILabel().then{
        $0.text = "Today's Pick"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .center
    }
    
    lazy var mainImg = UIImageView().then{
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var btnPlay = UIButton().then{
        $0.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        $0.tintColor = .black
        $0.imageView?.contentMode = .scaleToFill
    }

    lazy var slider = UISlider().then{
        $0.minimumValue = 0
        $0.maximumValue = 1
        $0.tintColor = .black
    }
    
    lazy var lblCurrent = UILabel().then{
        $0.text = "00:00"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .left
    }
    
    lazy var lblTotal = UILabel().then{
        $0.text = "00:00"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .right
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainImg)
        view.addSubview(lblSong)
        view.addSubview(lblAuthor)
        view.addSubview(btnPlay)
        view.addSubview(slider)
        view.addSubview(lblCurrent)
        view.addSubview(lblTotal)
        setupUI()
        bind(reactor: reactor)
    }
    
    private func setupUI(){
        
        mainImg.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.width.equalToSuperview().offset(30).multipliedBy(0.7)
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        lblSong.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainImg.snp.bottom).offset(50)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        
        lblAuthor.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lblSong.snp.bottom)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        
        btnPlay.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
            $0.width.equalToSuperview().multipliedBy(0.13)
            $0.height.equalToSuperview().multipliedBy(0.07)
        }
        
        slider.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(btnPlay.snp.top).inset(-30)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(btnPlay)
        }
        
        lblTotal.snp.makeConstraints{
            $0.right.equalToSuperview().inset(30)
            $0.top.equalTo(slider.snp.bottom)
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(slider).offset(-40)
        }
        
        lblCurrent.snp.makeConstraints{
            $0.left.equalToSuperview().offset(30)
            $0.top.equalTo(slider.snp.bottom)
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(slider).offset(-40)
        }
    }
    
    func bind(reactor:MusicDetailReactor){
        let firstLoad = rx.viewWillAppear
            .map { _ in () }
        
        Observable.merge(firstLoad)
            .map{ [weak self] in Reactor.Action.loadMusic(self?.music)}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map{$0.music}
            .subscribe{ [weak self] state in
                let model = state.element?.value?.convertToTrack()!
                self?.lblSong.text = model?.title
                self?.lblAuthor.text = model?.artist
                self?.mainImg.image = model?.artwork
            }.disposed(by: disposeBag)
        
    }
    
}
