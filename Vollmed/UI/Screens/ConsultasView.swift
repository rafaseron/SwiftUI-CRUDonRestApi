//
//  ConsultasView.swift
//  Vollmed
//
//  Created by Rafael Seron on 02/07/24.
//

import SwiftUI

struct ConsultasView: View {
    let service = WebService()
    @State var appointments: [Appointment] = []
    
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVStack{
                ForEach(appointments){ appointment in
                    SpecialistCardView(specialist: appointment.specialist)
                }
            }
        }.onAppear{
            //code
        }
        .task{
            await getAllAppointmentsForThisPatient()
        }
        .navigationTitle("Agendadas")
        .navigationBarTitleDisplayMode(.large)
        
        
    }
    
    // MARK: - Escopo dentro da struct ConsultasView
    
    func getAllAppointmentsForThisPatient() async {
        do{
            guard let appointmentList = try await service.getAppointmentsByPatientId(idPaciente: service.patientId) else{
                return
            }
            
            appointments = appointmentList
            
        }
        catch{
            print("Erro GET consultas by Id Paciente -> \(error)")
        }
    }
    
    
}

#Preview {
    ConsultasView()
}
