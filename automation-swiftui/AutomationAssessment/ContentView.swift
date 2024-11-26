//
//  ContentView.swift
//  AutomationAssessment
//
//  Created by Nicholas Jones - Mobile iPlayer - Erbium on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTag: Tag = Tag.initialDefault
    @State private var showingErrorAlert = false
    @State private var showingTVGuideAlert = false
    @State private var isLoading = false
    @State private var currentDate = Date.now
    @State private var destinationTag = NavigationPath()

    var titleView: some View {
        HStack {
            Text("My BBC")
                .font(.largeTitle)
                .accessibilityIdentifier(AutomationIdentifiers.homeTitle.rawValue)
            Spacer()
            Button {
                isLoading = true
                Task {
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    currentDate = .now
                    isLoading = false
                }
            } label: {
                Image(systemName: "arrow.clockwise.circle.fill")
            } // intentionally not adding an accessibility identifier to this button
        }
    }

    var placeholderImage: some View {
        Image("bbc_location")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaledToFit()
            .clipped()
            .padding(.top)
            .accessibilityAddTraits(.isImage)
    }

    var subtitleView: some View {
        VStack(alignment: .leading) {
            Text("Last updated: \(currentDate.formatted(date: .abbreviated, time: .standard))")
                .accessibilityIdentifier(AutomationIdentifiers.lastUpdated.rawValue)
                .font(.caption)
                .padding(.bottom)
            Text("This is a BBC app with all of your favourite BBC content.")
                .accessibilityIdentifier(AutomationIdentifiers.homeSubtitle.rawValue)
                .font(.subheadline)
        }
    }

    var headerView: some View {
        VStack {
            titleView
            placeholderImage
            subtitleView
        }
    }

    var tagSelector: some View {
        HStack {
            Button {
                switch selectedTag {
                case .tvGuide:
                    showingTVGuideAlert = true
                default:
                    destinationTag.append(selectedTag)
                }
            } label : {
                Text("Go to \(selectedTag.title)")
            }
            .accessibilityIdentifier(AutomationIdentifiers.tagNavigation.rawValue)

            Spacer()
            Picker("Tag", selection: $selectedTag) {
                ForEach(Tag.allCases, id: \.self) {
                    Text($0.title)
                }
            }
            .accessibilityIdentifier(AutomationIdentifiers.tagPicker.rawValue)
        }
    }

    var footer: some View {
        Button {
            showingErrorAlert = true
        } label: {
            Text("Breaking News")
                .padding()
                .font(.headline)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(Capsule())
        }
        .accessibilityIdentifier(AutomationIdentifiers.homeFooterButton.rawValue)
    }

    var loadingView: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .controlSize(.extraLarge)
            .background(Color.white.opacity(0.25))
    }

    var body: some View {
        NavigationStack(path: $destinationTag, root: {
                VStack {
                    headerView
                    tagSelector
                    Spacer()
                    footer
                }
                .padding()
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Image("homeNavIcon")
                        .accessibilityLabel("BBC logo")
                        .accessibility(removeTraits: .isImage)
                        .accessibilityAddTraits(.isHeader)
                }
            })
            .navigationDestination(for: Tag.self) { tag in
                TagContentView(tag: tag)
            }
        })
        .overlay {
            if isLoading {
                loadingView
            }
        }
        .alert("Something has gone wrong", isPresented: $showingErrorAlert) {
            Button("Ok", role: .cancel) {}
        }
        .alert("Do you have a TV license?", isPresented: $showingTVGuideAlert) {
            Button("Yes", role: .none) { destinationTag.append(Tag.tvGuide) }
            Button("No", role: .cancel) {}
        }
    }
}

#Preview {
    ContentView()
}

enum Tag: Hashable, CaseIterable {
    case politics
    case uk
    case sport
    case tech
    case world
    case tvGuide

    static var initialDefault: Tag { return .politics }
    var title: String {
        switch self {
        case .politics:
            return "Politics"
        case .uk:
            return "UK"
        case .sport:
            return "Sport"
        case .tech:
            return "Technology"
        case .world:
            return "World"
        case .tvGuide:
            return "TV Guide"
        }
    }
}
