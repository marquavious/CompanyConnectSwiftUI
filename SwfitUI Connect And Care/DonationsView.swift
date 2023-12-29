//
//  DonationsView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI

struct DonationsView: View {
    let userData = User(name: "Cack", donations: Donations.generateDonations())
    var body: some View {
        NavigationView {
                List {
                    Section {
                        ForEach(userData.donations, id: \.id) { donation in
                            HStack() {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.regularMaterial)
                                    .frame(width: 40, height: 40)

                                VStack(alignment: .leading) {
                                    Text("1/11/2018")
                                        .bold()

                                    Text(donation.company.category.name)
                                        .font(.system(size: 15))
                                        .lineLimit(1)
                                        .fontWeight(.semibold)
                                        .padding([.vertical], 6)
                                        .padding([.horizontal], 8)
                                        .foregroundColor(.white)
                                        .background(donation.company.category.color)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))

                                    Text(donation.company.orginizationName)
                                }

                                Spacer()

                                VStack(alignment: .trailing) {
                                    Text(donation.displayAmount())
                                        .bold()
                                    Text(donation.paymentMethod.displayName)
                                }
                            }
                        }
                    }
                header: { }

                    Section {
                        ForEach(userData.donations, id: \.id) { donation in
                            //                    Text(donation.company.orginizationName)

                            HStack() {

                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.regularMaterial)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                        //                                                            RoundedRectangle(cornerRadius: 8)
                                        //                                                                .fill(Color.white)
                                        //                                                                .padding(4)
                                    }

                                VStack(alignment: .leading) {
                                    Text("1/11/2018")
                                        .bold()


                                    Text(donation.company.category.name)
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .padding([.vertical], 6)
                                        .padding([.horizontal], 8)
                                        .foregroundColor(.white)
                                    //                                .background(.regularMaterial.opacity(0.1))
                                        .background(donation.company.category.color)
                                    //                                .environment(\.colorScheme, .dark)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 8)
                                        )

//                                    Text(donation.company.orginizationName)
                                }

                                Spacer()

                                VStack(alignment: .trailing) {
                                    Text(donation.displayAmount())
                                        .bold()
                                    //
                                    Text(donation.paymentMethod.displayName)
                                }
                            }

                        }
                    }
                header: {
                    Text("Schedueled")
                        .font(.title3)
//                        .foregroundColor(.white)
                        .padding([.vertical])
                } footer: {
                        Text(CompanyObject.generateShort())
                            .font(.caption)
                            .padding([.vertical])

                }
            }
                .contentMargins([.top], 16)
            .navigationTitle("Donations")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    DonationsView()
}
