//
//  ContentView.swift
//  ios_hw3_00857039
//
//  Created by User20 on 2022/11/15.
//

import SwiftUI

struct ContentView: View {
  @State private var allTask:[Task] = [
    Task(title: "看影片",taskClass:"休閒",isRepeatTask: true,date: Date(), difficulty:3, description: ""),
    Task(title: "寫程式",taskClass:"學習與工作",isRepeatTask: true,date: Date(), difficulty:3, description: "")
  ]
  
  @State private var allTaskClass:[String] = Task.alltaskClass
  @State private var edit: Bool = false
  @State private var add: Bool = false
  @State private var addClass: Bool = false
  @State private var showingOptions: Bool = false
  @State private var random: Bool = false
  @State private var isEditMode:EditMode = .inactive
  @State private var navigationTitle:String = "任務清單(To-Do List)"
  @State private var sayingIndex:Int = Int.random(in: 0...GlobalVar.saying.count-1)
  
  func deleteTask(at offsets: IndexSet) {
  allTask.remove(atOffsets: offsets)
  }
  func moveTask(from source:IndexSet,to destination:Int) {
  allTask.move(fromOffsets: source, toOffset: destination)
  }
  func deleteTaskClass(at offsets: IndexSet) {
      let o = offsets
      let idsToDelete = offsets.map { Task.alltaskClass[$0]}
      let deletedClass:String = idsToDelete[0]
      let maxIndex = allTask.count - 1
      for taskIndex in 0...maxIndex{
          if(allTask[taskIndex].taskClass == deletedClass){
              print(allTask[taskIndex].title)
              allTask[taskIndex].taskClass = "00857039wys899195"//刪除這個task
          }
      }
      allTaskClass.remove(atOffsets: o)
      Task.alltaskClass.remove(atOffsets: o)
      Task.alltaskClassColor.remove(atOffsets: o)
  }
  
    var body: some View {
      ZStack{
        NavigationView{
          List{
            DisclosureGroup {
              ForEach(Array(allTask.enumerated()), id: \.element.id){ index, task in
                if(task.taskClass == Task.alltaskClass[0]){
                  Button{
                    self.edit = true
                  }label:{
                    HStack{
                      if(allTask[index].isRepeatTask == true){
                        Image(systemName:"clock.arrow.2.circlepath")
                          .resizable()
                          .frame(width:18,height:18)
                      }else{
                        Image(systemName:"clock")
                          .resizable()
                          .frame(width:18,height:18)
                      }
                      Text(allTask[index].title)
                      Spacer()
                      Image(allTask[index].isCompleted ? "任務完成" : "")
                        .resizable()
                        .frame(width:95,height:22)
                    }
                    .fullScreenCover(isPresented: $edit){
                      editTaskView(allTask: $allTask, task: $allTask[index], show: $edit)
                    }
                  }
                }
              }
              .onDelete(perform: deleteTask)
              .onMove(perform: moveTask)
            }label: {
              Label(Task.alltaskClass[0], systemImage: "folder.fill")
                .foregroundColor(Color.black)
            }
            .listRowBackground(Task.alltaskClassColor[0])
            ForEach(Array(allTaskClass.enumerated()), id: \.1){classIndex,taskClass in
              if(taskClass != Task.alltaskClass[0]){
                DisclosureGroup {
                  ForEach(Array(allTask.enumerated()), id: \.element.id){ index, task in
                    if(task.taskClass == taskClass){
                      Button{
                        self.edit = true
                      }label:{
                        HStack{
                          if(allTask[index].isRepeatTask == true){
                            Image(systemName:"clock.arrow.2.circlepath")
                              .resizable()
                              .frame(width:18,height:18)
                          }else{
                            Image(systemName:"clock")
                              .resizable()
                              .frame(width:18,height:18)
                          }
                          Text(allTask[index].title)
                          Spacer()
                          Image(allTask[index].isCompleted ? "任務完成" : "")
                            .resizable()
                            .frame(width:95,height:22)
                        }
                        .fullScreenCover(isPresented: $edit){
                          editTaskView(allTask: $allTask, task: $allTask[index], show: $edit)
                        }
                      }
                    }
                  }
                  .onDelete(perform: deleteTask)
                  .onMove(perform: moveTask)
                }label: {
                  Label(taskClass, systemImage: "folder.fill")
                    .foregroundColor(Color.black)
                }
                .listRowBackground(Task.alltaskClassColor[classIndex])
              }
            }.onDelete(perform: deleteTaskClass)
          }
          .padding(.horizontal,20)
          .padding(.top,20)
          .toolbar {
              HStack{
                  Button(isEditMode.isEditing ? "完成編輯":"移動/刪除項目"){
                    switch isEditMode{
                    case .active:
                      self.isEditMode = .inactive
                      self.navigationTitle = "任務清單(To-Do List)"
                    case .inactive:
                      self.isEditMode = .active
                      self.navigationTitle = "(編輯中...)"
                    default:
                      break
                    }
                  }
              }
            
          }
          .environment(\.editMode, $isEditMode)
          .navigationBarTitleDisplayMode(.inline)
          .navigationTitle(navigationTitle)
        }
        VStack{
          Spacer()
          HStack{
            Text(GlobalVar.saying[sayingIndex])
              .padding(.leading,10)
              .padding(.bottom,10)
              .font(.custom("HanziPenTC-W5", size: 20))
            Spacer()
            VStack{
              Button {
                  showingOptions = true
              } label: {
                   Image(systemName: "plus.app.fill")
                     .resizable()
                     .frame(width: 60, height: 60)
                    .foregroundColor(Color.blue)
              }
              .padding(.trailing,10)
              .actionSheet(isPresented: $showingOptions) {
                  ActionSheet(
                      title: Text("添加..."),
                      buttons: [
                          .default(Text("新任務")) {
                              self.addClass = false
                              self.add = true
                              self.isEditMode = .inactive
                              self.navigationTitle = "任務清單(To-Do List)"
                          },
                          .default(Text("新分類")) {
                              self.addClass = true
                              self.add = true
                              self.isEditMode = .inactive
                            self.navigationTitle = "任務清單(To-Do List)"
                          },
                          .cancel(Text("取消"))
                      ]
                  )
              }
              Button {
              } label: {
                   Image(systemName: "heart.circle.fill")
                     .resizable()
                     .frame(width: 60, height: 60)
                    .foregroundColor(Color.red)
              }
              .contextMenu {
                Text("這是心靈雞湯產生器")
                  Button {
                      self.sayingIndex = Int.random(in: 0...GlobalVar.saying.count-1)
                  } label: {
                      Label("產生隨機心靈雞湯句子", systemImage: "location.circle")
                  }
              }
              .padding(.bottom,10)
              .padding(.trailing,10)
            }

          }

        }
      }
      .sheet(isPresented: $add){
        addTaskView(allTask: $allTask, show: $add,addClass: $addClass,allTaskClass:$allTaskClass)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
