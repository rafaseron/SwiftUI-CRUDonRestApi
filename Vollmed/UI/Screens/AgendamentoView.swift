//
//  AgendamentoView.swift
//  Vollmed
//
//  Created by Rafael Seron on 25/06/24.
//

import SwiftUI

struct AgendamentoView: View {
    var texto: String
    
    var body: some View {
        VStack{
            Text("Tela de agendamento")
            Text(texto)
        }
    }
}

#Preview {
    AgendamentoView(texto: "String")
}
