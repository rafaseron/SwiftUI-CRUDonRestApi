//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit
// usar UIImage faz com que seja preciso importar o UIKit

struct WebService {
    
    // MARK: - BASE URL
    
    private let baseURL = "http://192.168.100.36:3000"
    
    
    // MARK: - SPECIALISTS
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let getEndpoint = "\(baseURL)/especialista"
        
        guard let url = URL(string: getEndpoint) else {
            print("URL Error")
            return nil
        }
        
        var getRequest = URLRequest(url: url)
        getRequest.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: getRequest)
        
        let dataDecode = try JSONDecoder().decode([Specialist].self, from: data)
        return dataDecode
    }
    
    // MARK: - ASYNCIMAGE
    
    // Vamos receber um 'from url: String' ao inves de 'url: String'
    // Isso nos permite receber um 'data' de argumento do parametro, ao invés de nos limitar a receber apenas uma String
    func asyncImage(from url: String) async throws -> UIImage? {
        
        guard let imageEndPoint = URL(string: url) else {
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: imageEndPoint)
        
        let dataImage = UIImage(data: data)
        return dataImage
        
    }
    
    // MARK: - APPOINTMENTS
    
    func postAppointment(specialistId: String, patientId: String, date: String) async throws -> ScheduleResponse?{
        let endpoint = baseURL+"/consulta"
        // método http -> POST
        
        guard let url = URL(string: endpoint) else{
            return nil
        }
        
        // Fazer Enconde dos dados da aplicacao para serem enviados na Requisicao
        let data = try JSONEncoder().encode(ScheduleRequest(specialistID: specialistId, patientID: patientId, date: date))
        
        
        // Definir o método HTTP, o Body e o Header
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")    // Header
        request.httpBody = data                                                     // Body
        
        // Por fim, iniciar a Sessao usando o Request feito anteriormente
        let session = try await URLSession.shared.data(for: request)
        
        
        // Agora vamos Decodificar o Data recebido após Sessao
        let dataResponse = try JSONDecoder().decode(ScheduleResponse.self, from: session.0)
        return dataResponse
        
    }
    
    func getAllAppointments(){
        let endpoint = baseURL+"/consulta"
        
    }
    
    func getAppointmentById(){
        let endpoint = baseURL+"/consulta/:id"
    }
    
    func updateAppointment(){
        let endpoint = baseURL+"/consulta/:id"
        // método http -> PATCH
    }
    
    func deleteAppointment(){
        let endpoint = baseURL+"/consulta/:id"
    }
    
    
}
