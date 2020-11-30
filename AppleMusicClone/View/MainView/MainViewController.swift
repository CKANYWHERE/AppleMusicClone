//
//  MainViewController.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/24.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa
import RxViewController
import RxDataSources
import RxOptional
import ReactorKit
import Gedatsu

class MainViewController: UIViewController,ReactorKit.View {
    
    //var item : AVPlayerItem?
    
    
//    @objc func cardTapped(_ sender: UIButton, item:AVPlayerItem) {
//       // guard item != nil else { return }
//        let musicDetailVC = MusicDetailViewController()
//        musicDetailVC.music = item
//        self.present(musicDetailVC, animated: true)
//    }
    
    var disposeBag = DisposeBag()
    let reactor = MainReactor()
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<TrackSection>(configureCell:{
        dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as! MainCollectionCell
        let track = item.convertToTrack()
        cell.imgView.image = track?.artwork
        cell.lblAuthor.text = track?.artist
        cell.lblSong.text = track?.title
        return cell
    },configureSupplementaryView: {(ds ,cv, kind, ip) in
        let section = cv.dequeueReusableSupplementaryView(ofKind: kind,
                                   withReuseIdentifier: "collectionViewHeader", for: ip) as! MainCollectionHeader
        let randomAv = ds[ip.section].items.randomElement()
        let randomTrack = randomAv?.convertToTrack()
        section.lblTodayPick.text = "Today's Pick is \(randomTrack!.artist)'s album"
        section.headerImage.image = randomTrack!.artwork
        section.item = randomAv
        section.tapHandler = { item in
            let musicDetailVC = MusicDetailViewController()
            musicDetailVC.music = item
            self.present(musicDetailVC, animated: true)
        }
        return section
    })

     
    lazy var layout = UICollectionViewFlowLayout().then{
        $0.itemSize =  CGSize(width: (view.bounds.width/2)-40, height: (view.bounds.height/4))
        $0.headerReferenceSize = CGSize(width: (view.bounds.width), height: (view.bounds.height/2))
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.contentInset = UIEdgeInsets(top:10, left: 20, bottom: 10, right: 20)
        $0.backgroundColor = .white
        $0.register(MainCollectionHeader.self
                    , forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader
                    , withReuseIdentifier: "collectionViewHeader")
        $0.register(MainCollectionCell.self, forCellWithReuseIdentifier: "collectionView")
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        //bindCollectionView()
        bind(reactor: reactor)
    }
    
    func bind(reactor: MainReactor) {
        
        let firstLoad = rx.viewWillAppear
            .map { _ in () }
        
        Observable.merge(firstLoad)
            .map{_ in Reactor.Action.loadAlbum}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        collectionView.rx.willDisplaySupplementaryView.subscribe(onNext: { reUseableView, kind, indexPath in
            print("will display the partition indexPath as: \(indexPath)")
            print("Head or tail will be displayed: \(kind)")
            print("will show the head or tail view: \(reUseableView)\n")
        }).disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(AVPlayerItem.self)
            .subscribe(onNext:{item in
                let musicDetailVC = MusicDetailViewController()
                musicDetailVC.music = item
                musicDetailVC.simplePlayer.replaceCurrentItem(with: item)
                self.present(musicDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
        
        
        reactor.state.map{$0.albums}
            .bind(to: collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
    
    func setupUI() {
        view.addSubview(collectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalToSuperview()
        }
    }
    
  
}
