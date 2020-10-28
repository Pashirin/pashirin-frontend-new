////
////  ChatRow.swift
////  chatApp4
////
////  Created by Ryu Tamura on 2020/10/15.
////
//import SwiftUI
//
//struct ChatRow: View {
//    var chatData : MsgModel
//    @State private var user = UserDefaults.standard.string(forKey: "current_user")
//    @State private var transactionId = UserDefaults.standard.string(forKey: "transactionId")
//    
//    var body: some View {
//        
//        HStack(spacing: 15){
//
//            if chatData.user != user{
//                
//                NickName(name: chatData.user)
//            }
//            
//            if chatData.user == user{Spacer(minLength: 0)}
//            
//            VStack(alignment: chatData.user == user ? .trailing : .leading, spacing: 5, content: {
//                
//                if chatData.user == user {
//                    Text(chatData.msg)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color(red: 1.00, green: 0.55, blue: 0.36))
//                    // Custom Shape...
//                        .clipShape(ChatBubble(myMsg: chatData.user == user))
//                } else {
//                    Text(chatData.msg)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.black)
//                        .padding()
//                        .background(Color(red: 1.00, green: 0.88, blue: 0.36))
//                    // Custom Shape...
//                        .clipShape(ChatBubble(myMsg: chatData.user == user))
//                }
//                
//                Text(chatData.timeStamp,style: .time)
//                    .font(.caption2)
//                    .foregroundColor(.gray)
//                    .padding(chatData.user != user ? .leading : .trailing , 10)
//            })
//            
//            if chatData.user == user{
//                
//                NickName(name: chatData.user)
//            }
//            
//            if chatData.user != user{Spacer(minLength: 0)}
//        }
//        .padding(.horizontal)
//        // For Scroll Reader....
//        .id(chatData.id)
//    }
//}
//
//struct NickName : View {
//    
//    var name : String
//    @State private var user = UserDefaults.standard.string(forKey: "current_user")
//    
//    var body: some View{
//        
//        Text(String(name))
//            .font(.system(size: 15))
//            .fontWeight(.heavy)
//            .foregroundColor(.white)
//            .frame(width: 50, height: 50)
//            .background((name == user ? Color.blue : Color.green).opacity(0.5))
//            .clipShape(Circle())
//            // COntext menu For Name Display...
//            .contentShape(Circle())
//            .contextMenu{
//    
//                Text(name)
//                    .fontWeight(.bold)
//            }
//    }
//}
import SwiftUI

struct ChatRow: View {
    var chatData : MsgModel
    @State private var user = UserDefaults.standard.string(forKey: "current_user")
    @State private var transactionId = UserDefaults.standard.string(forKey: "transactionId")
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    var nowTime = Date()
    
    
    var body: some View {
        HStack(spacing: 15){
            
            if chatData.user != user{
                
                NickName(name: chatData.user)
            }
            
            if chatData.user == user{Spacer(minLength: 0)}
            
            VStack(alignment: chatData.user == user ? .trailing : .leading, spacing: 5, content: {
                
                if chatData.user == user {
                    Text(chatData.msg)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(red: 1.00, green: 0.55, blue: 0.36))
                        // Custom Shape...
                        .clipShape(ChatBubble(myMsg: chatData.user == user))
                } else {
                    Text(chatData.msg)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(red: 1.00, green: 0.88, blue: 0.36))
                        // Custom Shape...
                        .clipShape(ChatBubble(myMsg: chatData.user == user))
                }
                
                
                
                
                //                Text(chatData.timeStamp,style: .time)
                Text("\(nowTime, formatter: ChatRow.taskDateFormat)")
                    //                    .font(.caption2)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .padding(chatData.user != user ? .leading : .trailing , 10)
            })
            
            if chatData.user == user{
                
                NickName(name: chatData.user)
            }
            
            if chatData.user != user{Spacer(minLength: 0)}
        }
        .padding(.horizontal)
        // For Scroll Reader....
        .id(chatData.id)
    }
}

struct NickName : View {
    
    var name : String
    @State private var user = UserDefaults.standard.string(forKey: "current_user")
    
    var body: some View{
        
        Text(String(name))
            .font(.system(size: 10))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background((name == user ? Color.blue : Color.green).opacity(0.5))
            .clipShape(Circle())
            // COntext menu For Name Display...
            .contentShape(Circle())
            .contextMenu{
                
                Text(name)
                    .fontWeight(.bold)
            }
    }
}
