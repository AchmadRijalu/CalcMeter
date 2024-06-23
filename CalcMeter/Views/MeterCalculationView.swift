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
    @FocusState var isInputActive: Bool
    var body: some View {
        GeometryReader { geo in
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
                        
                    }.padding(.horizontal, 12)
                    List {
                        Section{
                            TextField("Masukkan Angka", text: $angkaTextField).keyboardType(.decimalPad)
                                .padding(4)
                                .overlay(RoundedRectangle(cornerRadius: 24).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0)))
                                .onReceive(Just(angkaTextField)) { value in
                                    let allowedInput = "0123456789,"
                                    let filtered = value.filter { allowedInput.contains($0) }
                                    let commaCounter = filtered.filter { $0 == ","}.count
                                    
                                    if angkaTextField.first == "," {
                                        angkaTextField = "0" + angkaTextField
                                    }
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
                                .focused($isInputActive)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Done") {
                                            isInputActive = false
                                        }
                                    }
                                }
                        }header: {
                            HStack(spacing: 0){
                                Text("Angka dalam")
                                Text(meterOption.rawValue == "m - cm" ? " Meter" : " Centimeter")
                            }
                        }
                        Section{
                            HStack{
                                Text(String(meterCalculationViewModel.meterCalculcationModel.calculationResult))
                                Spacer()
                                Text(meterOption.rawValue == "m - cm" ? "Cm" : " Meter")
                            }
                        }header: {
                            Text("Hasil")
                        }
                    }.listStyle(InsetGroupedListStyle())
                    
                    Spacer()
                    Button(action: {
                        switch (meterOption){
                        case .meter:
                            meterCalculationViewModel.meterCalculcationModel.calculationResult = meterCalculationViewModel.meterToCentimeterCalculation(from: angkaTextField ?? "")
                        case .centiMeter:
                            meterCalculationViewModel.meterCalculcationModel.calculationResult = meterCalculationViewModel.centiMeterToMeterCalculation(from: angkaTextField ?? "")
                        }
                        
                    }, label: {
                        Text("Calculate").frame(maxWidth: geo.size.width * 0.75).padding(.vertical, 8).foregroundStyle(.white).bold()
                    }).buttonStyle(.borderedProminent).buttonBorderShape(.capsule).padding(EdgeInsets(top: 16, leading: 12, bottom: 36, trailing: 12))
                    
                }
                .navigationTitle("Calculation")
            }
        }
        
    }
}

#Preview {
    MeterCalculationView( meterCalculationViewModel: MeterCalculationViewModel())
}
