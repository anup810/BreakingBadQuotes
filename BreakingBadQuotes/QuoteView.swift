//
//  QuoteView.swift
//  BreakingBadQuotes
//
//  Created by Anup Saud on 2024-07-17.
//

import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show:String
    @State var showCharacterInfo = false
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7 , height: geo.size.height*1.2)
    
                VStack{
                    VStack{
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom, content: {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .background(.ultraThinMaterial)
                                
                            })
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 50, style: .continuous))
                            .onTapGesture {
                                showCharacterInfo.toggle()
                            }
                            .sheet(isPresented: $showCharacterInfo, content: {
                                CharacterView(character: vm.character, show: show)
                            })
                        
                        case .failed(let error):
                            Text(error.localizedDescription)
                          
                        }
                        
                        Spacer()
                    }
                    Button{
                        Task{
                            await vm.getData(for:show)
                        }
            
                        
                    }label: {
                        Text("Get Random Quote")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                            .clipShape(.rect(cornerRadius: 7, style: .circular))
                            .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
                    }
                    Spacer(minLength: 95)
     
                    
                }.frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width  , height: geo.size.height)
        }.ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: "Better Call Saul")
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
