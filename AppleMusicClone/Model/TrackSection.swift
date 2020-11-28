//
//  TrackSection.swift
//  AppleMusicClone
//
//  Created by 민창경 on 2020/11/26.
//

import Foundation
import RxDataSources
import AVFoundation

struct TrackSection {
    var header: String
    var items: [Item]
}

public protocol TrackSectionType
{
    associatedtype Item
    var items: [Item] { get }
    init(original: Self, items: [Item])
}

extension TrackSection: SectionModelType {
    typealias Item = AVPlayerItem
    init(original: TrackSection, items: [Item]) {
        self = original
        self.items = items
    }
}

struct AlbumSection {
    var header: String
    var items: [Item]
}

public protocol AlbumSectionType
{
    associatedtype Item
    var items: [Item] { get }
    init(original: Self, items: [Item])
}

extension AlbumSection: SectionModelType {
    typealias Item = Album
    init(original: AlbumSection, items: [Item]) {
        self = original
        self.items = items
    }
}


//
//struct FriendInfoSection {
//    var header: String
//    var items: [Item]
//}
//
//public protocol FriendInfoSectionType
//{
//    associatedtype Item
//    var items: [Item] { get }
//    init(original: Self, items: [Item])
//}
//
//
//extension FriendInfoSection : SectionModelType {
//  typealias Item = FriendModel
//
//   init(original: FriendInfoSection, items: [Item]) {
//    self = original
//    self.items = items
//  }
//}
