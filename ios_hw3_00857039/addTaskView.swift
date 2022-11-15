//
//  addTaskView.swift
//  ios_hw3_00857039
//
//  Created by User20 on 2022/11/15.
//

import SwiftUI

struct addTaskView: View {
  
  @Binding var allTask: [Task]
  @Binding var show: Bool
  @Binding var addClass: Bool
  @Binding var allTaskClass: [String]
  @State private var showAlert: Bool = false
  @State private var newTaskClassName:String = ""
  @State private var task = Task(title: "", isRepeatTask: false, description: "")
  @State private var classColor = Color.white
  
    var body: some View {
      if(addClass == true){
        VStack{
          HStack{
            Button{
              show = false
          
            }label:{
                Image(systemName: "arrowshape.turn.up.left.circle")
                  .resizable()
                  .frame(width: 40, height: 40)
                  .foregroundColor(.black)
            }
            .padding(.leading,20)
            .padding(.top,10)
            Spacer()
            Button{
              if(newTaskClassName.isEmpty){
                    showAlert = true
                }
                else{
                    allTaskClass.append(newTaskClassName)
                    Task.alltaskClass.append(newTaskClassName)
                    Task.alltaskClassColor.append(classColor)
                    show = false
                }
            }label:{
                Image(systemName: "checkmark.circle")
                  .resizable()
                  .frame(width: 40, height: 40)
                  .foregroundColor(.green)
            }
            .padding(.trailing,20)
            .padding(.top,10)
          }
          Form{
            HStack{
              Text("類別名稱")
                .frame(width:80)
              Divider()
              TextField("請輸入新類別名稱", text: $newTaskClassName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
              ColorPicker("設定類別顏色", selection: $classColor)
          }
   
        }.alert(isPresented: $showAlert) { Alert(title: Text("類別名稱不能為空！"), dismissButton:  .default(Text("我知道了"))   )}
      }else{
        VStack{
          HStack{
            Button{
              show = false
            }label:{
                Image(systemName: "arrowshape.turn.up.left.circle")
                  .resizable()
                  .frame(width: 40, height: 40)
                  .foregroundColor(.black)
            }
            .padding(.leading,20)
            .padding(.top,10)
            Spacer()
            Button{
              if(task.title.isEmpty){
                    showAlert = true
                }
                else{
                  self.allTask.append(task)
                  show = false
                }
            }label:{
                Image(systemName: "checkmark.circle")
                  .resizable()
                  .frame(width: 40, height: 40)
                  .foregroundColor(.green)
            }
            .padding(.trailing,20)
            .padding(.top,10)
          }
          TaskFormView(task: $task,isEdit: false)
   
        }.alert(isPresented: $showAlert) { Alert(title: Text("任務名稱不能為空！"), dismissButton:  .default(Text("我知道了"))   )}
      }
      
    }
}

