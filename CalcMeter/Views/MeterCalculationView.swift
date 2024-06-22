//
//  MeterCalculationView.swift
//  CalcMeter
//
//  Created by Achmad Rijalu on 21/06/24.
//

import SwiftUI
import Combine

struct MeterCalculationView: View {
    @State var meterOption: MeterOption = .meter
    @ObservedObject var meterCalculationViewModel: MeterCalculationViewModel
    @State var angkaTextField: String = ""
    var body: some View {
        NavigationView {
            VStack{
                Picker("What is your favorite color?", selection: $meterOption) {
                    ForEach(MeterOption.allCases, id: \.self){ result in
                        Text(verbatim: "\(result.rawValue)").tag(result)
                    }
                    
                }.pickerStyle(.segmented).onChange(of: meterOption) { result in
                    
                    
                    switch (result) {
                    case .meter:
                        angkaTextField = ""
                        meterCalculationViewModel.meterCalculcationModel.calculationResult = ""
                        
                    case .centiMeter:
                        angkaTextField = ""
                        meterCalculationViewModel.meterCalculcationModel.calculationResult = ""
                    default:
                        angkaTextField = ""
                    }
                    
                }
                TextField("Masukkan Angka", text: $angkaTextField).keyboardType(.decimalPad)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                
                    .padding().padding(EdgeInsets(top: 12, leading: 12, bottom: 40, trailing: 12))
                    .onReceive(Just(angkaTextField)) { value in
                        let allowedInput = "0123456789,"
                        let filtered = value.filter { allowedInput.contains($0) }
                        let commaCounter = filtered.filter { $0 == ","}.count
                        if commaCounter > 1 {
                            if let commaEnteredTwice = filtered.range(of: "," , options: .backwards) {
                                let newFilter = filtered.replacingCharacters(in: commaEnteredTwice, with: "")
                                self.angkaTextField = newFilter
                            }
                        }
                        if filtered != value {
                            self.angkaTextField = filtered
                        }
                    }
                HStack{
                    Text(String(meterCalculationViewModel.meterCalculcationModel.calculationResult))
                }
                
                
                Button(action: {
                    meterCalculationViewModel.meterCalculcationModel.calculationResult = meterCalculationViewModel.meterToCentimeterCalculation(from: angkaTextField ?? "")
                    print(meterCalculationViewModel.meterCalculcationModel.calculationResult)
                }, label: {
                    Text("Calculate").frame(maxWidth: .infinity).padding(.vertical, 12)
                }).buttonStyle(.borderedProminent).buttonBorderShape(.capsule)
                
                Spacer()
            }.padding(.horizontal, 12)
            
                .navigationTitle("Calculation")
        }
    }
}

#Preview {
    MeterCalculationView( meterCalculationViewModel: MeterCalculationViewModel())
}
