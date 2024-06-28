//
//  SpecialistCardView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct SpecialistCardView: View {
    
    var specialist: Specialist
    
    let service = WebService()
    @State var image: UIImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                
                if image == nil{
                    Image(.doctor)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                } else {
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(specialist.name)
                        .font(.title3)
                        .bold()
                    Text(specialist.specialty)
                }
            }
            NavigationLink{
                AgendamentoView(specialist: specialist)
            } label: {
                ButtonView(text: "Agendar consulta")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.lightBlue).opacity(0.15))
        .cornerRadius(16.0)
        .task {
            await updateDoctorImage()
        }
        .navigationTitle("Médicos")
        
        /* Para alterar o texto do BackButton do NavigationView, precisamos nomear a View que foi responsável pela navegação
           Sendo assim, por mais que o 'SpecialistCardView' está dentro de 'HomeView' e o usuário clicou no 'agendar consulta' na 'HomeView',
           na verdade quem fez a navegação foi o 'SpecialistCardView', porque é aqui que o NavigationLink se encontra.
           Sendo assim, é aqui que devemos nomear. Importante lembrar de nomear com textos pequenos, porque se for muito maior que 'Back - 4 caracteres',
           vai ficar com o padrao 'Back' mesmo. Aqui no caso foi nomeado apenas com 'Médicos - 7 caracteres'
         */
        
    }
    
    // MARK: - funcoes dentro do escopo de SpecialistCardView
    
    func updateDoctorImage() async {
        do{
            guard let receivedImage = try await service.asyncImage(from: specialist.imageUrl) else {
                return
            }
            image = receivedImage
        }
        catch{
            print("ocorreu um erro durante atualizacao da imagem: \(error)")
        }
        
    }
    
}

#Preview {
    SpecialistCardView(specialist:
        Specialist(id: "c84k5kf",
                   name: "Dr. Carlos Alberto",
                   crm: "123456",
                   imageUrl: "https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=752&q=80",
                   specialty: "Neurologia",
                   email: "carlos.alberto@example.com",
                   phoneNumber: "(11) 99999-9999"
                  ))
}
