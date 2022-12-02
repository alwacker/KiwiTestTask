//
//  PopularFlightsView.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import SwiftUI
import Combine

struct PopularFlightsView: View {

    @ObservedObject private var viewModel: PopularFlightsViewModel

    @State private var date: Date = Date()

    @State private var selectedItem: Flight?

    init(viewModel: PopularFlightsViewModel) {
        self.viewModel = viewModel
        viewModel.didAppear.send(date)
    }

    var body: some View {
        ZStack {
            Color.pink
                .ignoresSafeArea()
                .opacity(0.3)

            VStack {
                switch viewModel.state {
                case .loading:
                    SpinnerView()

                case let .success(flights):
                    DatePicker("Select date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(CustomDatePickerStyle())
                        .padding()
                    
                    TabView {
                        ForEach(flights) {
                            FlightView(flight: $0, selectedItem: $selectedItem)
                                .padding(.horizontal,30)
                                .padding(.bottom, 70)
                        }
                    }
                    .padding(.top,30)
                    .padding(.bottom,30)
                    .tabViewStyle(.page(indexDisplayMode: .always))

                case let .error(error):
                    showErrorView(with: error)

                default:
                    EmptyView()
                }
            }
        }
        .navigationTitle("Popular flights")
        .navigationBarTitleDisplayMode(.automatic)
        .onChange(of: date) {
            viewModel.didAppear.send($0)
        }
        .onChange(of: selectedItem) { newValue in
            viewModel.selectedItem.send(newValue)
            selectedItem = nil
        }
    }

    private func showErrorView(with error: Error) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.white.opacity(0.6))
                .frame(width: UIScreen.main.bounds.width * 0.7, height: 300.0)
                .addBackgroundShadow()
                .overlay(
                    VStack(alignment: .center) {
                        Text("Oops, something goes wrong! Please try it again! \n Error: \(error.localizedDescription)")
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .foregroundColor(.pink.opacity(0.3))
                            .frame(
                                width: UIScreen.main.bounds.width * 0.15,
                                height: UIScreen.main.bounds.width * 0.15,
                                alignment: .center
                            )
                            .onTapGesture {
                                withAnimation(.linear(duration: 1.0)) {
                                    viewModel.didAppear.send(date)
                                }
                            }
                    }
                    .padding()
                    .padding(.top,20)
                )
        }
    }
}

struct PopularFlightsView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularFlightsView(viewModel: PopularFlightsViewModel(service: DIContainer().flightsModuleService, router: FlightsModuleRouter(container: DIContainer(), transitionHandler: AppRouter(container: DIContainer()))))
        }
    }
}
