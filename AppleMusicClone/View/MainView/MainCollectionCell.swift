//
//  MainCollectionCell.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/24.
//

import UIKit
import Gedatsu

class MainCollectionCell: UICollectionViewCell {
    
    lazy var imgView = UIImageView().then {
       // $0.setTitle("login", for: .normal)
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var lblAuthor = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 9)
    }
    
    lazy var lblSong = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        contentView.backgroundColor = .white
        contentView.addSubview(imgView)
        contentView.addSubview(lblAuthor)
        contentView.addSubview(lblSong)
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(item: Track?) {
        guard let track = item else { return }
        imgView.image = track.artwork
        lblSong.text = track.title
        lblAuthor.text = track.artist
    }
    

    func setUpLayout(){
       
        imgView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        lblSong.snp.makeConstraints{ make in
           // make.top.equalTo(lblAuthor.snp.bottom).offset(5.0)
            make.top.equalTo(imgView.snp.bottom).offset(5.0)
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        
        lblAuthor.snp.makeConstraints{ make in
          //  make.top.equalTo(imgView.snp.bottom).offset(5.0)
            make.top.equalTo(lblSong.snp.bottom).offset(5.0)
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
 
    }
    
}
