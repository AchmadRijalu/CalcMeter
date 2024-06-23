//
//  ContentView.swift
//  CalcMeter
//
//  Created by Achmad Rijalu on 21/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var meterCalculationViewModel = MeterCalculationViewModel()
    var body: some View {
        MeterCalculationView(meterCalculationViewModel: meterCalculationViewModel)
        
    }
}

#Preview {
    ContentView(meterCalculationViewModel: MeterCalculationViewModel())
}
