//
//  TaskFormView.swift
//  ios_hw3_00857039
//
//  Created by User20 on 2022/11/15.
//

import SwiftUI

struct TaskFormView: View {
  
  @Binding var task: Task
  @State var selectedId:Int = 0
  @State private var difficultyStarStr:String = ""
  @State private var difficultyStarColorIndex:Int = 0
  var difficultyStarColor:[Color] = [Color.gray,Color.green,Color.yellow,Color.orange,Color.red]
  var isEdit:Bool
    var body: some View {
      VStack{
        Form{
          if(isEdit == true){
            Toggle(task.isCompleted ? "任務已完成":"任務未完成", isOn: $task.isCompleted)
              .padding(.horizontal,80)
              .foregroundColor(task.isCompleted ? .green : .red)
          }
          HStack{
            Text("任務名稱")
              .frame(width:80)
            Divider()
          
            TextField("請輸入任務名稱(必填）", text: $task.title)
              .textFieldStyle(RoundedBorderTextFieldStyle())
          }
          HStack{
            Text("類別")
              .frame(width:80)
            Divider()
        
            Text("\(task.taskClass)")
              .padding(.leading,8)
              .lineLimit(nil)
            Spacer()
            Picker(selection: $task.taskClass,label: Text("選擇類別")) {
              ForEach(Array(Task.alltaskClass.enumerated()), id: \.element) { index,taskClass in
                Text(taskClass).tag(index)
              }
            }.pickerStyle(MenuPickerStyle())
          }

        
          Toggle("是否為每日重複", isOn: $task.isRepeatTask)
          if task.isRepeatTask {
            HStack{
              Text("時間")
                .frame(width:80)
              Divider()
              DatePicker("", selection: $task.date,displayedComponents: .hourAndMinute)
            }
          }
          else{
            HStack{
              Text("預定時間")
                .frame(width:80)
              Divider()
              DatePicker("", selection: $task.date)
            }
          }
          HStack{
            Text("任務難度")
              .frame(width:80)
            Divider()
            VStack{
              Slider(value: $task.difficulty, in: 1...5, step: 1)
              HStack{
                Text(difficultyStarStr)
                  .foregroundColor(difficultyStarColor[difficultyStarColorIndex])
                  .font(.custom("HanziPenTC-W5", size: 20))
                  .onAppear(){
                    switch task.difficulty{
                    case 1:
                      difficultyStarStr = "★"
                      difficultyStarColorIndex = 0
                    case 2:
                      difficultyStarStr = "★★"
                      difficultyStarColorIndex = 1
                    case 3:
                      difficultyStarStr = "★★★"
                      difficultyStarColorIndex = 2
                    case 4:
                      difficultyStarStr = "★★★★"
                      difficultyStarColorIndex = 3
                    case 5:
                      difficultyStarStr = "★★★★★"
                      difficultyStarColorIndex = 4
                    default:
                      difficultyStarStr = ""
                    }
                  }
                  .onChange(of: task.difficulty, perform: { value in
                    switch task.difficulty{
                    case 1:
                      difficultyStarStr = "★"
                      difficultyStarColorIndex = 0
                    case 2:
                      difficultyStarStr = "★★"
                      difficultyStarColorIndex = 1
                    case 3:
                      difficultyStarStr = "★★★"
                      difficultyStarColorIndex = 2
                    case 4:
                      difficultyStarStr = "★★★★"
                      difficultyStarColorIndex = 3
                    case 5:
                      difficultyStarStr = "★★★★★"
                      difficultyStarColorIndex = 4
                    default:
                      difficultyStarStr = ""
                    }
                })
                Spacer()
                Stepper("", value: $task.difficulty,in: 1...5, step: 1)
              }
              
            }
          }
          HStack{
            Text("任務描述")
              .frame(width:80)
            TextEditor(text: $task.description)
                .frame(height: 150)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
          }
          
          
        }
      }
    }
}

struct TaskFormView_Previews: PreviewProvider {
 @State static var task: Task = Task(title: "寫程式",taskClass: Task.alltaskClass[0],isRepeatTask: true,date: Date(), difficulty:5, description: "")
    static var previews: some View {
      TaskFormView(task: $task,isEdit: true)
    }
}
