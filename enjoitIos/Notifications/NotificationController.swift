//
//  NotificationController.swift
//  enjoitIos
//
//  Created by developapp on 17/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import UserNotifications

public class NotificationController{
    
    static func notify(notificacionitem:NotificacionItem){
        
      //let trigger = UNNotificationTrigger(coder: )
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let content = setNotification(title: "Enjoit app", subtitle: notificacionitem.titulo, body: notificacionitem.info)
        let request = UNNotificationRequest(identifier: String(notificacionitem.id), content: content, trigger: trigger)
        // 4. Añadimos la Request al Centro de Notificaciones
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
           if let error = error {
              print("Se ha producido un error: \(error)")
           }
        }
    }
    
    static func setNotification(title:String,subtitle:String,body:String) -> UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = subtitle
        //content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        return content
    }

}


struct NotificacionItem:Identifiable{
    var titulo:String = ""
    var img:String = ""
    var info:String = ""
    var fecha:String = ""
    var id:Int;
    var type:String;
    
    init(tipoS:String,rest:String,estado:String?,producto:String?,KeyCm:String,idPedido:String,orderType:String){
        self.type = tipoS
        switch tipoS {
           case "Cambio Comanda": //nc = nueva cita y cambio de estados
                switch orderType {
                    case "24"://Pedido Domicilio
                    self.img = ""
                    self.titulo = "Estado de pedido, " + rest
                    self.info =  "el estado de su " + producto! + " ha cambiado a " + estado!;
                    break
                    
                default:
                    self.img = "logoProbi"
                    self.titulo = "Ocurrio error en la notificacion"
                    self.info = "Notificacion Erronea"
                    self.fecha = "00/00/00"
                    break
                }
            break
    
            case "PagoPorPos": //nc = nueva cita y cambio de estados
                self.img = ""
                self.titulo = "Pago Realizado"
                self.info =  "Su pedido en el restaurante " + rest + " fue pagado en el pos, Gracias por utilizar nuestros servicios";
            break
            
           default:
            self.img = "logoProbi"
            self.titulo = "Ocurrio error en la notificacion"
            self.info = "Notificacion Erronea"
            self.fecha = "00/00/00"
            break
        }
        
        self.id = Int(idPedido) ?? 0
        
    }
    
}




