//
//  ParticipantDetailView.swift
//  LetSwift Data Manager
//
//  Created by BumMo Koo on 04/08/2019.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct ParticipantDetailView: View {
    @State private var presentNew = false
    
    @EnvironmentObject var store: DataStore
    @EnvironmentObject var participant: Participant
    
    private var newSocialAccountButton: some View {
        Button(action: newSocialAccount) {
            Text("New Social Account...")
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Profile", selection: $participant.profile) {
                    List {
                        ForEach(store.profiles) { profile in
                            Text(profile.preferredName)
                                .tag(profile)
                        }
                    }
                }
                Picker("Role", selection: $participant.role) {
                    List {
                        ForEach(Participant.Role.allCases) { role in
                            Text(role.localizedName)
                            .tag(role)
                        }
                    }
                }
                TextField("Description", text: $participant.description)
            }
            Section(header: Text("Image")) {
                TextField("Image URL", text: $participant.imageUrlString)
            }
            Section(header: Text("Social Account")) {
                newSocialAccountButton
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(participant.profile.preferredName)
        .sheet(isPresented: $presentNew) {
            NewSocialAccountView()
        }
    }
    
    // MARK: - Action
    private func newSocialAccount() {
        presentNew.toggle()
    }
}

#if DEBUG
struct ParticipantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipantDetailView()
    }
}
#endif
