//
//  AgendamentoView.swift
//  Vollmed
//
//  Created by Rafael Seron on 25/06/24.
//

import SwiftUI

struct AgendamentoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let specialist: Specialist
    var appointment: Appointment?
    @State var isRescheduleView: Bool = false
    @State var scheduleResponse: String? = nil
    @State var showAlert: Bool = false
    
    let service: WebService = WebService()
    
    @State private var data: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6.0){
            Text("Selecione a data e horário da consulta")
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
                .padding(.top)
            
            if isRescheduleView{
                if appointment != nil{
                    Text("Sua data atual é: \(appointment!.appointmentDate.toReadableDate())")
                        .bold()
                    
                    // TODO -> Atualizar o valor de 'data' com o valor da consulta atualmente marcada. >> A funcao ta pronta <<
                    // getDateOnRescheduleView()
                    // Preciso conseguir executar essa funcao no escopo de View
                }
                
            }else {
                Text("Data no padrao do Swift -> \(data)")
            }
            
            
            DatePicker("Escola a data da consulta", selection: $data)
                .datePickerStyle(.graphical)
            
            Button(action: {
                Task{
                    if !isRescheduleView{
                        await postSchedule()
                    } else {
                        // await updateSchedule
                        print ("Rodar updateSchedule aqui")
                    }
                }
                
                
            }, label: {
                ButtonView(text: isRescheduleView ? "Remarcar consulta" : "Agendar consulta")
            }).alert("Agendamento de consultas", isPresented: $showAlert, presenting: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Ok")
                })
            }, actions: { actions in
                //actions code
            }, message: { message in
                if scheduleResponse != nil{
                    Text(scheduleResponse!)
                } else{
                    Text("Tivemos um problema")
                }
            }) // Este alert, diferente do anterior, você consegue definir como vai ser o botão, e ai pode adicionar códigos que
               // não são aceitos dentro de um Protocol 'View'.
            
            // Porém não funcionou o .dimiss(), então fica o código anterior abaixo:
            
            
            /*
            .alert("Agendamento de consultas", isPresented: $showAlert, actions: {
                //actions code
            }, message: {
                if scheduleResponse != nil{
                    Text(scheduleResponse!)
                } else{
                    Text("Tivemos um problema")
                }
            })*/

            
        }
        .padding(.all)
        .navigationTitle(isRescheduleView ? "Remarcar" : "Agendar")
        .navigationBarTitleDisplayMode(.large)
        .onAppear{
            UIDatePicker.appearance().minuteInterval = 15
        }
    }
    
    // MARK: - Métodos no Escopo da Struct View

    func postSchedule() async {
        
        do{
            // Tentando realizar o Post e já desenbrulhando a 'ScheduleResponse' que receberemos do 'postAppointment'
            guard let response = try await service.postAppointment(specialistId: specialist.id, patientId: service.patientId, date: data.toString()) else {
                scheduleResponse = nil
                return
            }
            
            // Receber a Data agendada no 'scheduleResponse'. Transformar em Data Legível ao Usuario.
            scheduleResponse = "Consulta agendada para: \(response.date.toReadableDate())"
            showAlert = true
            
        } catch{
           
            scheduleResponse = "Oops! ... Considere agendar com um profissional que você não tenha consultas no mesmo dia e das 7h as 19h. Se os problemas persistirem, por favor entre em contato."
            showAlert = true
            
        }
        
    }
    
    func getDateOnRescheduleView(){
        guard let receivedDate = appointment!.appointmentDate.toDate() else{
            return
        }
        
        data = receivedDate
        
    }
    
}

#Preview {
    AgendamentoView(specialist: Specialist(id: "String", name: "String", crm: "String", imageUrl: "String", specialty: "String", email: "String", phoneNumber: "String"))
}
