//
//  SkyMemo.swift
//  SkyMemoApp
//
//  Created by simyo on 2021/09/26.
//

import UIKit

struct SkyMemo: Codable, Equatable {
//    나중에 Date type으로 바꿀건지?
    let date: String
    var skyImage: String
    var oneLineMemeo: String
    
    mutating func update(skyImage: String, oneLineMemo: String) {
        self.skyImage = skyImage
        self.oneLineMemeo = oneLineMemo
    }
    
}

class SkyMemoManager {
    static let shared = SkyMemoManager()
    
    var skyMemos: [SkyMemo] = []
    
    func createSkyMemo(skyImage: String, oneLineMemo: String) -> SkyMemo{
        return SkyMemo(date: "210927", skyImage: skyImage, oneLineMemeo: oneLineMemo)
    }
    
    func addSkyMemo(_ skyMemo: SkyMemo){
        skyMemos.append(skyMemo)
        saveSkyMemo()
    }
    
    func deleteSkyMemo(_ skyMemo: SkyMemo){
//        skyMemos = skyMemos.filte { $0.}
        saveSkyMemo()
    }
    
    func updateSkyMemo(_ skyMemo: SkyMemo){
        guard let index = skyMemos.firstIndex(of: skyMemo) else { return }
        skyMemos[index].update(skyImage: skyMemo.skyImage, oneLineMemo: skyMemo.oneLineMemeo)
        saveSkyMemo()
    }
    
    func saveSkyMemo() {
//        Storage.store
    }
}
