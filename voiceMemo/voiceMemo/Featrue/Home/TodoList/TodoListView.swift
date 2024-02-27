//
//  TodoListView.swift
//  voiceMemo
//
//  Created by 엄태양 on 2/9/24.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewmodel: TodoListViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
    var body: some View {
        WriteBtnView(
            content: {
                VStack {
                    if !todoListViewmodel.todos.isEmpty {
                        CustomNavigationBar(
                            isDisplayLeftBtn: false,
                            rightBtnAction: {
                                todoListViewmodel.navigationRightBtnTapped()
                            },
                            rightBtnType: todoListViewmodel.navigationBarRightBtnMode
                        )
                    } else {
                        Spacer()
                            .frame(height: 30)
                    }
                    
                    TitleView()
                        .padding(.top, 20)
                    
                    if todoListViewmodel.todos.isEmpty {
                        AnnouncementView()
                    } else {
                        TodoListContentView()
                            .padding(.top, 20)
                    }
                    
                    
                }
            },
            action: { pathModel.paths.append(.todoView)}
        )
        
//        .modifier(WriteBtnViewModifier(action: { pathModel.paths.append(.todoView)}))
//        .writeBtn {
//            pathModel.paths.append(.todoView)
//        }
        .alert(
            "To do List \(todoListViewmodel.removeTodosCount)개 삭제 하시겠습니까?",
            isPresented: $todoListViewmodel.isDisplayRemoveTodoAlert
        ) {
            Button("삭제", role: .destructive) {
                todoListViewmodel.removeBtnTapped()
            }
            Button("취소", role: .cancel) {
                
            }
        }
        .onChange(of: todoListViewmodel.todos, perform: { todos in
            homeViewModel.setTodoCount(todos.count)
        })
        
    }
    

}

//MARK: - Todo List TitleView

private struct TitleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        HStack {
            if todoListViewModel.todos.isEmpty {
                Text("To do List를\n추가해 보세요.")
            } else {
                Text("To do List \(todoListViewModel.todos.count)개가\n있습니다.")
            }
            
            Spacer()
            
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

//MARK: - TodoList AnnouncementView

private struct AnnouncementView: View {
    fileprivate var body: some View {
        VStack(spacing:15) {
            Spacer()
            
            Image("pencil")
                .renderingMode(.template)
            Text("\"매일 아침 5시 운동하자!\"")
            Text("\"내일 8시 수강 신청하자!\"")
            Text("\"1시 반 점심 약속 리마인드 해보자!\"")
            
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}

//MARK: - TodoList ContentView

private struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("할일 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack {
                    Rectangle()
                        .fill(.customGray0)
                        .frame(height: 1)
                    
                    ForEach(todoListViewModel.todos, id: \.self) { todo in
                        // TODO: - Todo 셀 뷰 todo 넣어서 뷰 호출
                        
                        TodoCellView(todo: todo)
                    }
                }
            }
        }
    }
}

//MARK: - Todo Cell View

private struct TodoCellView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo: Todo
    
    fileprivate init(
        isRemoveSelected: Bool = false,
        todo: Todo
    ) {
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.todo = todo
    }
    
    fileprivate var body: some View {
        VStack(spacing: 20) {
            HStack {
                if !todoListViewModel.isEditMode {
                    Button(
                        action: { todoListViewModel.selectedBoxTapped(todo) },
                        label: { todo.selected ? Image("selectedBox") : Image("unSelectedBox")}
                    )
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(todo.title)
                        .font(.system(size: 16))
                        .foregroundColor(todo.selected ? .customIconGray : .customBlack)
                        .strikethrough(todo.selected)
                    
                    Text(todo.convertedDayAndTime)
                        .font(.system(size: 16))
                        .foregroundColor(.customIconGray)
                }
                
                Spacer()
                
                if todoListViewModel.isEditMode {
                    Button (
                        action : {
                            isRemoveSelected.toggle()
                            todoListViewModel.todoRemoveSelectedBoxTapped(todo)
                        },
                        label: {
                            isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
                        }
                    
                    )
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    
        Rectangle()
            .fill(.customGray0)
            .frame(height: 1)
        
    }
}

//MARK: - Todo Create Btn View

private struct WriteTodoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel

    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button(
                    action: {
                        pathModel.paths.append(.todoView)
                    },
                    label: { Image("writeBtn")}
                )
            }
        }
    }
}

#Preview {
    TodoListView()
        .environmentObject(PathModel())
        .environmentObject(TodoListViewModel())
}
