//
//  MainViewController.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import RxDataSources
import RxOptional
import ReactorKit
import Gedatsu

class MainViewController: UIViewController,ReactorKit.View {
    
    var disposeBag = DisposeBag()
    let reactor = MainReactor()
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<TrackSection>(configureCell:{
        dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as! MainCollectionCell
        cell.imgView.image = item.artwork
        cell.lblAuthor.text = item.artist
        cell.lblSong.text = item.title
        return cell
    })
    
    lazy var layout = UICollectionViewFlowLayout().then{
        $0.itemSize =  CGSize(width: (view.bounds.width/2)-20, height: (view.bounds.height/5))
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
        $0.contentInset = UIEdgeInsets(top:10, left: 10, bottom: 10, right: 10)
        $0.backgroundColor = .white
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
    
//    func bindCollectionView(){
//        let musics = Observable.of([
//                                    MusicModel(author: "test", song: "test", img: "test")
//                                    ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
//                                   ,MusicModel(author: "test2", song: "test2", img: "test2")]
//                                   )
//
//        musics.bind(to: collectionView.rx.items(cellIdentifier: "collectionView", cellType: MainCollectionCell.self)){ index, song, cell in
//            cell.imgView.image = UIImage(named: song.img ?? "")
//            cell.lblAuthor.text = song.author
//            cell.lblSong.text = song.song
//
//        }.disposed(by: disposeBag)
//
//    }
}
