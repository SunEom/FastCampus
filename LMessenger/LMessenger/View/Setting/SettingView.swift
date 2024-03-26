//
//  SettingView.swift
//  LMessenger
//
//  Created by 엄태양 on 3/26/24.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SettingViewModel
    @EnvironmentObject var appearanceConroller: AppearanceController
    @AppStorage(AppStorageType.Appearance) var appearance: Int = UserDefaults.standard.integer(forKey: AppStorageType.Appearance)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sectionItems) { section in
                    Section {
                        ForEach(section.settings) { setting in
                            Button {
                                if let a = setting.item as? AppearanceType {
                                    appearanceConroller.changeAppearance(a)
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
        .preferredColorScheme(appearanceConroller.appearance.colorSchme)
    }
}

#Preview {
    SettingView(viewModel: .init())
}
