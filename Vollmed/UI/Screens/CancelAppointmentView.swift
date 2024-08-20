//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Rafael Seron on 20/08/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    @State private var newTextValue: String = ""
    
    var body: some View {
        LazyVStack(spacing: 16){
            Text("Qual seria o motivo do cancelamento?")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
            
            
            TextEditor(text: $newTextValue)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.secondarySystemBackground))
                .frame(minHeight: 200, maxHeight: 300)
                .clipShape(.buttonBorder)
                .padding(.horizontal)
                
            
            Button(action: {
                print("Botao de Cancelar pressionado")
                // await onDeleteClick()
                
            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
                    .padding(.horizontal)
            })
            
        }.navigationTitle("Cancelar")
            .navigationBarTitleDisplayMode(.large)
        
    }
}

#Preview {
    CancelAppointmentView()
}
