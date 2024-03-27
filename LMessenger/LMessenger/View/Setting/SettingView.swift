//
//  SettingView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var container: DIContainer
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SettingViewModel
    @AppStorage(AppStorageType.Appearance) var appearance: Int = UserDefaults.standard.integer(forKey: AppStorageType.Appearance)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sectionItems) { section in
                    Section {
                        ForEach(section.settings) { setting in
                            Button {
                                if let a = setting.item as? AppearanceType {
                                    container.appearanceController.changeAppearance(a)
                                    appearance = a.rawValue
                                }
                            } label: {
                                Text(setting.item.label)
                                    .foregroundColor(.bkText)
                            }
                        }
                    } header: {
                        Text(section.label)
                    }
                }
            }
            .navigationTitle("설정")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image("close_search")
                }
            }
        }
        .preferredColorScheme(container.appearanceController.appearance.colorSchme)
    }
}

#Preview {
    SettingView(viewModel: .init())
}
