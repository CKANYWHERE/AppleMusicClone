//
//  MainCollectionHeader.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/27.
//

import Foundation
import UIKit

class MainCollectionHeader: UICollectionReusableView{
    
    lazy var headerTitle = UILabel().then{
        $0.text = "Today's Pick"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 40)
    }
    
    lazy var warpButton = UIButton().then{
        $0.backgroundColor = .darkGray
        $0.alpha = 0.8
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var headerImage = UIImageView().then{
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var lblPlayNow = UILabel().then{
        $0.text = "Play Now"
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .white
    }
    
    lazy var lblTodayPick = UILabel().then{
        $0.text = "Today's pick is prisma - DarkMoon"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    lazy var playImg = UIImageView().then{
        $0.image = UIImage(systemName: "play.circle.fill")
        $0.tintColor = .systemPink
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerTitle)
        self.addSubview(headerImage)
        headerImage.addSubview(warpButton)
        headerImage.addSubview(lblPlayNow)
        headerImage.addSubview(lblTodayPick)
        headerImage.addSubview(playImg)
        setUpLayout()
     }

     required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
     }

     func setUpLayout() {
        
        headerTitle.snp.makeConstraints{
            $0.left.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(15)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
    }
        
        headerImage.snp.makeConstraints{
            $0.left.equalToSuperview().offset(0)
            $0.top.equalTo(headerTitle.snp.bottom).offset(15)
            $0.width.equalTo(headerTitle.snp.width)
            $0.height.equalToSuperview().multipliedBy(0.65)
        }
        
        warpButton.snp.makeConstraints{
            $0.trailing.leading.equalTo(headerImage)
            $0.top.bottom.equalTo(headerImage)
            $0.width.equalTo(headerImage)
            $0.height.equalTo(headerImage)
        }
        
        lblTodayPick.snp.makeConstraints{
            $0.left.equalTo(headerImage).offset(5)
            $0.bottom.equalTo(headerImage).inset(5)
            $0.width.equalTo(headerImage).multipliedBy(0.7)
            $0.height.equalTo(headerImage).multipliedBy(0.2)
        }
        
        lblPlayNow.snp.makeConstraints{
            $0.left.equalTo(headerImage).offset(5)
            $0.bottom.equalTo(lblTodayPick).offset(5)
            $0.width.equalTo(headerImage)
            $0.height.equalTo(headerImage).multipliedBy(0.1)
        }
        
        playImg.snp.makeConstraints{
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalTo(lblTodayPick)
            $0.width.equalTo(lblTodayPick.snp.height)
            $0.height.equalTo(lblTodayPick)
        }
        
     }
    
}
