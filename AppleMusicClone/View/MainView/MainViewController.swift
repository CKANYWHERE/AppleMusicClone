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
import RxOptional
import ReactorKit
import Gedatsu

class MainViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    lazy var layout = UICollectionViewFlowLayout().then{
        //$0.estimatedItemSize = CGSize(width: (view.bounds.width), height: (view.bounds.height/5))
        $0.itemSize =  CGSize(width: (view.bounds.width/2)-10, height: (view.bounds.height/5))
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    override func viewDidLoad() {
      super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        bindCollectionView()
    }
    
    func setupUI() {
        view.addSubview(collectionView)
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: "collectionView")
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalToSuperview()
        }
    }
 
    func bindCollectionView(){
        let musics = Observable.of([
                                    MusicModel(author: "test", song: "test", img: "test")
                                    ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")
                                   ,MusicModel(author: "test2", song: "test2", img: "test2")]
                                   )
                                   
        musics.bind(to: collectionView.rx.items(cellIdentifier: "collectionView", cellType: MainCollectionCell.self)){ index, song, cell in
            cell.imgView.image = UIImage(named: song.img ?? "")
            cell.lblAuthor.text = song.author
            cell.lblSong.text = song.song
           
        }.disposed(by: disposeBag)
        
    }
}
