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
        let calculation = numberInput.doubleValue * 100
        return removeTrailingZero(calculation)
    }
    func centiMeterToMeterCalculation(from numberInput: String) -> String{
        let calculation = numberInput.doubleValue / 100
        return calculateSmallDecimalResult(calculation)
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
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = false
    formatter.maximumFractionDigits = 20
    return formatter.string(from: NSNumber(value: temp)) ?? ""
}


func calculateSmallDecimalResult(_ number: Double) -> String {
    //MARK: - for make readable when the number decimal is too small, ex: 0,00088
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 20
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: number)) ?? ""
}
