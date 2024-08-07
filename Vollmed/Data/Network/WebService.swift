//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit
// usar UIImage faz com que seja preciso importar o UIKit

struct WebService {
    
    let patientId: String = "61c55f06-aeb9-4ef7-a706-6a29e6eccbc8"
    
    
    // MARK: - BASE URL
    
    private let baseURL = "http://192.168.100.36:3000"
    
    
    // MARK: - SPECIALISTS
    
    func getAllSpecialists() async throws -> [Specialist]? {
        // Preparar a URL
        let getEndpoint = "\(baseURL)/especialista"
        
        guard let url = URL(string: getEndpoint) else {
            print("URL Error")
            return nil
        }
        
        // Prepar o Request
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"
        
        // Iniciar a Sessao
        let (data, _) = try await URLSession.shared.data(for: getRequest)
        
        // Decodificar o 'Data' recebido na Sessao e retornar
        let dataDecode = try JSONDecoder().decode([Specialist].self, from: data)
        return dataDecode
    }
    
    // MARK: - ASYNCIMAGE
    
    // Vamos receber um 'from url: String' ao inves de 'url: String'
    // Isso nos permite receber um 'data' de argumento do parametro, ao invés de nos limitar a receber apenas uma String
    func asyncImage(from url: String) async throws -> UIImage? {
        
        // Preparar a URL
        guard let imageEndPoint = URL(string: url) else {
            return nil
        }
        
        // Iniciar a Sessao
        let (data, _) = try await URLSession.shared.data(from: imageEndPoint)
        
        // Transformar o 'Data' recebido em uma 'UIImage' e retornar
        let dataImage = UIImage(data: data)
        return dataImage
        
    }
    
    // MARK: - APPOINTMENTS
    
    func postAppointment(specialistId: String, patientId: String, date: String) async throws -> ScheduleResponse?{
        let endpoint = baseURL+"/consulta"
        // método http -> POST
        
        // Preparar a URL
        guard let url = URL(string: endpoint) else{
            return nil
        }
        
        // Fazer Enconde dos dados da aplicacao para serem enviados na Requisicao
        // Perceba que usamos o type como Request de schedule
        let data = try JSONEncoder().encode(ScheduleRequest(specialistID: specialistId, patientID: patientId, date: date))
        
        print("data -> \(date)")
        print("patientId -> \(patientId)")
        print("specialistId -> \(specialistId)")
        
        
        // Definir o método HTTP, o Body e o Header
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")    // Header
        request.httpBody = data                                                     // Body
        
        // Por fim, iniciar a Sessao usando o Request feito anteriormente
        let session = try await URLSession.shared.data(for: request)
        
        
        // Agora vamos Decodificar o Data recebido após Sessao
        // Perceba que usamos o type como Response de schedule
        let dataResponse = try JSONDecoder().decode(ScheduleResponse.self, from: session.0)
        return dataResponse
        
    }
    
    func getAppointmentsByPatientId(idPaciente: String) async throws -> [Appointment]? {
        let endpoint: String = baseURL+"/paciente/"+idPaciente+"/consultas"
        
        guard let url = URL(string: endpoint) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = try await URLSession.shared.data(for: request)
        let data = session.0
        let response = session.1
        
        let decodedData = try JSONDecoder().decode([Appointment].self, from: data)
        return decodedData
        
        
    }
    
    // TODO
    func updateAppointment(){
        let endpoint = baseURL+"/consulta/:id"
        // método http -> PATCH
    }
    
    // TODO
    func deleteAppointment(){
        let endpoint = baseURL+"/consulta/:id"
    }
    
    /*
    func getAllAppointments(){
        let endpoint = baseURL+"/consulta"
        
    }
    
    func getAppointmentById(){
        let endpoint = baseURL+"/consulta/:id"
    }
     */
    
    
}
