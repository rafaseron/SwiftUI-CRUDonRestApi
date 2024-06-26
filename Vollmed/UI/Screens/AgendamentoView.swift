//
//  AgendamentoView.swift
//  Vollmed
//
//  Created by Rafael Seron on 25/06/24.
//

import SwiftUI

struct AgendamentoView: View {
    let specialist: Specialist
    
    @State private var data: Date = Date()
    
    var body: some View {
        VStack{
            Text("Selecione a data e horário da consulta")
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
                .padding(.top)
            
            DatePicker("Escola a data da consulta", selection: $data, in: data...)
                .datePickerStyle(.graphical)
            
            Button(action: {
                print("Botão de agendar consulta pressionado")
                print(data)
                print(data.toString())
                print(data.toString().toReadableDate())
                
                // Preparativos para a requisicao
                //specialist.id
                //id do paciente
                //data.toString()
                
                
            }, label: {
                ButtonView(text: "Agendar consulta")
            })
            
            
        }
        .padding(.all)
        .navigationTitle("Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear{
            UIDatePicker.appearance().minuteInterval = 15
        }
    }
}

#Preview {
    AgendamentoView(specialist: Specialist(id: "String", name: "String", crm: "String", imageUrl: "String", specialty: "String", email: "String", phoneNumber: "String"))
}
