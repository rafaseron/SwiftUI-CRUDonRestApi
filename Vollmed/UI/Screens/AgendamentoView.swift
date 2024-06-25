//
//  AgendamentoView.swift
//  Vollmed
//
//  Created by Rafael Seron on 25/06/24.
//

import SwiftUI

struct AgendamentoView: View {
    @State private var data: Date = Date()
    
    var body: some View {
        VStack{
            Text("Selecione a data e horário da consulta")
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
                .padding(.top)
            
            DatePicker("Escola a data da consulta", selection: $data)
                .datePickerStyle(.graphical)
            
            Button(action: {
                print("Botão de agendar consulta pressionado")
            }, label: {
                ButtonView(text: "Agendar consulta")
            })
            
            
        }
        .padding(.all)
        .navigationTitle("Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    AgendamentoView()
}
