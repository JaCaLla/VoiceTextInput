//
//  ContentView.swift
//  DebugSwiftAppDemo
//
//  Created by Javier Calatrava on 6/12/24.
//
import SwiftUI

struct CharacterView: View {
    @ObservedObject var viewModel = CharacterViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.characters) { character in
                    NavigationLink {
                        DetailView(detailViewModel: DetailViewModel(character: character))
                    } label: {
                        HStack {
                            characterImageView(character.imageUrl)
                            Text("\(character.name)")
                            Spacer()
                        }
                    } 
                }
            }
        }
        .padding()
        .onAppear {
//            Task {
//                 await viewModel.fetch()
//            }
//            viewModel.fetchComb()
            viewModel.fetchFut()
        }
    }
    
    fileprivate func characterImageView(_ string: String) -> AsyncImage<_ConditionalContent<some View, some View>> {
        return AsyncImage(url: URL(string: string),
                          transaction:  .init(animation: .easeIn(duration: 0.2))) { phase in
            switch phase {
            case .success(let image):
                image .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100) 
                    .clipped()
                
            default:
                Image(systemName: "checkmark.rectangle")
                    .clipped()
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    CharacterView()
}
