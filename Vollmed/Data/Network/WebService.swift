//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit
// usar UIImage faz com que seja preciso importar o UIKit

struct WebService {
    
    private let baseURL = "http://192.168.100.36:3000"
    
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
    
    
}
