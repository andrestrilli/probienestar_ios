//
//  FirebaseController.swift
//  enjoitIos
//
//  Created by developapp on 17/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class FirebaseController{

    static var ref: DatabaseReference?;

    static func fijarReferencia() {
        self.ref = Database.database().reference(withPath: "APP/"+"\(DataApp.user!.idUsuario)");
        
        _ = ref!.observe(DataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            let node = snapshot.value as AnyObject
            let ref:DatabaseReference = snapshot.ref
            print(node)
            print(node["is_viewed"] as? Bool)
            let isvisto:Bool = ((node["is_viewed"] as? Bool) ?? true); //para que no me muestre si hay algun error
            print(isvisto)
                if  isvisto == false {
                    //tomo el tipo de notifiacion que me enviaron
                    let type:Int = node["type_notificacion"] as? Int ?? 0
                    
                    switch type {
                    case 13: //Cambios de comanda
                        let restaurante:String = node["name_sender"] as? String ?? ""
                        let producto:String = node["product_name"] as? String ?? ""
                        let estadoComanda:String = node["comanda_status"] as? String ?? ""
                        let ordertype:Int = node["order_type"] as? Int ?? 0
                        let idOrder:String = node["id_order"] as? String ?? "0"

                        let newNotificacion:NotificacionItem = NotificacionItem(tipoS: "Cambio Comanda", rest: restaurante, estado: estadoComanda, producto: producto, KeyCm: "", idPedido:idOrder, orderType: "\(ordertype)")
                        NotificationController.notify(notificacionitem: newNotificacion);
                        ref.child("is_viewed").setValue(true)
                        break
                        
                    case 20: //Pedido Pagado por el post
                        let restaurante:String = node["name_sender"] as? String ?? ""
                        let ordertype:Int = node["order_type"] as? Int ?? 0
                        let idOrder:String = node["id_order"] as? String ?? "0"

                        let newNotificacion:NotificacionItem = NotificacionItem(tipoS: "PagoPorPos", rest: restaurante, estado: nil, producto: nil, KeyCm: "", idPedido:idOrder, orderType: "\(ordertype)")
                        NotificationController.notify(notificacionitem: newNotificacion);
                        ref.child("is_viewed").setValue(true)
                        break
                        
                    default:
                        print("Erro Notificaicon")
                        break
                    }
                    
                    
                    
                    
                    
//                    let idEstado:String = node["idState"] as! String
//                    let idReserva:String = node!["idReserva"] as! String
//                    let nameDoctor:String = node!["nameDoctor"] as! String
//                    let nameSpecialty:String = node!["nameSpecialty"] as! String
//                    let fechaCita:String = node!["fechaCita"] as! String
//                    let type:String = node!["type"] as! String
//
//                        if type == "nc" {
//                            let newNotificacion:NotificacionItem = NotificacionItem(type: "nc",id: 0,idEstado: "\(idEstado)", nameDoctor: nameDoctor, nameSpeciality: nameSpecialty, fechaCita: fechaCita)
//                            NotificationController.notify(notificacionitem: newNotificacion);
//                            ref.child("isViewed").setValue(true)
//                        }
//
//                        if type == "rc" {
//                            let newNotificacionRc:NotificacionItem = NotificacionItem(type: "rc",id: 0,idEstado: "\(idEstado)", nameDoctor: nameDoctor, nameSpeciality: nameSpecialty, fechaCita: fechaCita)
//                            NotificationController.notify(notificacionitem: newNotificacionRc);
//                            ref.child("isViewed").setValue(true)
//                        }
//
//                        if type == "rco" {
//                            let newNotificacionRco:NotificacionItem = NotificacionItem(type: "rco", id: 0,idEstado: "\(idEstado)", nameDoctor: nameDoctor, nameSpeciality: nameSpecialty, fechaCita: fechaCita)
//                            NotificationController.notify(notificacionitem: newNotificacionRco);
//                            ref.child("isViewed").setValue(true)
//                        }
                        
                        
                
        }
        
    })

}
    
    static func getReference() -> DatabaseReference{
        ref = Database.database().reference(withPath: "USER/"+"\(DataApp.user!.idUsuario)");
        
        return ref!
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
     
        completionHandler([.alert, .sound])
    }
}
