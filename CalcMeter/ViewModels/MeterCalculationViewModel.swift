//
//  MeterCalculationViewModel.swift
//  CalcMeter
//
//  Created by Achmad Rijalu on 21/06/24.
//

import Foundation


class MeterCalculationViewModel: ObservableObject {
    @Published var meterCalculcationModel: MeterCalculationModel = MeterCalculationModel(calculationResult: "")
    
    func meterToCentimeterCalculation(from numberInput: String) -> String{
        var calculation = numberInput.doubleValue * 100
        return removeTrailingZero(calculation)
    }
}
enum MeterOption: String, Hashable, CaseIterable{
    case meter = "m - cm"
    case centiMeter = "cm - m"
}

extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
func removeTrailingZero(_ temp: Double) -> String {
    var replaceZero = String(format: "%g", temp)
    return replaceZero
}
