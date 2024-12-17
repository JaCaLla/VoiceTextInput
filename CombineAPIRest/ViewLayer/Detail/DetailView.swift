//
//  DetailView.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import SwiftUI

struct DetailView: View {
    @StateObject var detailViewModel: DetailViewModel = DetailViewModel(character: .sample)
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: detailViewModel.character.imageUrl))
                .clipShape(Circle())
            Form {
                Section {
                    LabeledContent("form_name".localized, value: detailViewModel.character.name)
                    LabeledContent("form_status".localized, value: detailViewModel.character.status)
                    LabeledContent("form_species".localized, value: detailViewModel.character.species)
                    
                } header: {
                    Text("section_character".localized)
                }
                Section {
                    LabeledContent("form_location".localized, value: detailViewModel.character.location)
                    LabeledContent("form_type".localized, value: detailViewModel.character.type)
                } header: {
                    Text("section_site".localized)
                }
                Section {
                    LabeledContent("form_numberOfEpisodes".localized, value: "\(detailViewModel.character.numberOfEpisodes)")
                } header: {
                    Text("section_episodes".localized)
                }
            }.background(Color.green)
        }

    }
}

#Preview {

    let viewModel = DetailViewModel(character: .sampleMorty)
    let detailView = DetailView(detailViewModel: viewModel)
    return detailView
}

