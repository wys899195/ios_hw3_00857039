//
//  GlobalVar.swift
//  ios_hw3_00857039
//
//  Created by User20 on 2022/11/15.
//

import Foundation
import SwiftUI

struct GlobalVar{
  static var saying:[String] = [
    "時間就像海綿里的水，只要願擠，總還是有的。\n——魯迅",
    "莫等閒，白了少年頭，空悲切！\n——岳飛",
    "在今天和明天之間，有一段很長的時間；趁你還有精神的時候，學習迅速辦事。\n——歌德",
    "合理安排時間，就等於節約時間。\n——培根",
    "平庸的人關心怎樣耗費時間，有才能的人竭力利用時間。\n——阿圖爾·叔本華",
    "拋棄時間的人，時間也拋棄他。\n——莎士比亞",
    "荒廢時間等於荒廢生命。\n——川端康成",
    "從不浪費時間的人，沒有工夫抱怨時間不夠。\n——傑弗遜",
    "在世界上我們只活一次，所以應該愛惜光陰。必須過真實的生活，過有價值的生活。\n——伊萬·巴甫洛夫",
    "明日復明日，明日何其多，我生待明日，萬事成蹉跎。\n——《明日歌》"
  ]
}

struct Task:Identifiable{
  let id = UUID()
  var title:String
  var taskClass:String = "未分類"
  var isCompleted:Bool = false
  var isRepeatTask:Bool
  var date = Date()
  var difficulty:Double = 3
  var description:String
}

extension Task{
  
  static var alltaskClass = [
    "未分類","學習與工作","休閒"
  ]
  
  static var alltaskClassColor = [
    Color.gray,Color.orange,Color.green
  ]
  
}
