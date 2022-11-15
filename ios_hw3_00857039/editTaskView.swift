//
//  editTaskView.swift
//  ios_hw3_00857039
//
//  Created by User20 on 2022/11/15.
//

import SwiftUI

struct editTaskView: View {
  
  @Binding var allTask: [Task]
  @Binding var task: Task
  @Binding var show: Bool
  @State private var showAlert: Bool = false
  
    var body: some View {
      VStack{
        HStack{
          Spacer()
          Button{
            if(task.title.isEmpty){
                  showAlert = true
              }
              else{
                  show = false
              }
          }label:{
              Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.green)
          }
          .padding(.trailing,20)
        }
        TaskFormView(task: $task,isEdit: true)
      }.alert(isPresented: $showAlert) { Alert(title: Text("任務名稱不能為空！"), dismissButton:  .default(Text("我知道了"))   )}
    }
}

