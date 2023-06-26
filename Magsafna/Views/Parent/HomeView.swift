//
//  HomeView.swift
//  GP-OnboardingSign
//
//  Created by لجين إبراهيم الكنهل on 27/11/1444 AH.
//

import SwiftUI
// Remaining : 
struct HomeView: View {
    @StateObject var vm = DataManager()
    @State var expandCards: Bool = false
    @State var currentCard: Card?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    var body: some View {
        NavigationStack{
        VStack(spacing: 0) {
            
            Text ("Children Cards")
                .font(.custom( "Play-Regular", size: 28))
                . fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment:
                        expandCards ? .leading : .center)
                .overlay(alignment: .trailing) {
                    
                    //  Close Button
                    Button {
                        
                        withAnimation(
                            .interactiveSpring(response: 0.8,dampingFraction: 0.7,
                                               blendDuration: 0.7)){
                                                   expandCards = false
                                               }
                    } label: {
                        Image (systemName: "plus")
                            .foregroundColor(.white)
                            .padding (10)
                            .background (.blue, in: Circle ())
                    }
                    .rotationEffect(.init(degrees: expandCards
                                          ? 45 : 0))
                    .opacity (expandCards ? 1 : 0)
                }
                .padding (.horizontal, 15)
                .padding(.bottom,10)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 5){
                    ForEach(vm.cards){
                        card in
                        Group{
                            if currentCard?.id == card.id && showDetailCard{
                                CardView(card: card)
                                    .opacity(0)
                                
                            }else{
                                CardView(card: card)
                                    .matchedGeometryEffect(id: card.id, in: animation)
                            }
                        }
                        //
                        .onTapGesture{
                            withAnimation(
                                .easeInOut(duration: 0.35)){
                                    currentCard = card
                                    showDetailCard = true
                                }
                        }
                        
                    }
                }
                .overlay{
                    Rectangle()
                        .fill(.black.opacity(expandCards ? 0 : 0.01))
                        .onTapGesture {
                            withAnimation((.easeInOut(duration: 0.35))){
                                expandCards = true
                            }
                        }
                }
                .padding(.top,expandCards ? 30 : 0)
            }
            .coordinateSpace(name: "SCROLL")
            .offset(y: expandCards ? 0 : 30)
            
            //add cart
            
            NavigationLink{AddChildView()} label: {
                
               
                    Image (systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
            
                        .background (Color("purplei"), in: Circle ())
                
                    
             
                
                
            }
            .rotationEffect(.init(degrees: expandCards
                                  ? 180 : 0))
            .scaleEffect(expandCards ? 0.01 : 1)
            .opacity (!expandCards ? 1 : 0)
            .frame(height: expandCards ? 0 : nil)
            .padding(.bottom,expandCards ? 0 : 70)

            
        }.padding(.top)
        .onAppear{
            vm.fetchAllChild()
        }
        }
        .padding([.horizontal,.top])
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .overlay{
            if let currentCart = currentCard,showDetailCard{
                DetailView(currentCard: currentCart, showDetailCard: $showDetailCard,animation:animation)
            }
        }
    }
    
    
    @ViewBuilder func CardView(card: Card)->some View{
        GeometryReader{proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            let offset = CGFloat(getIndex(Card: card) * (expandCards ? 10 : 70))
            ZStack(alignment: .bottomLeading){
                
              
                Rectangle()
                    .cornerRadius(20)
                LinearGradient(gradient: Gradient(colors: card.cardColor), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .cornerRadius(20)
                   // .foregroundColor(card.cardColor)
                    .frame(width: 360,height: 200)
                   // .cornerRadius(20)
                

                //.foregroundColor(Color(card.cardColor as! CGColor) )
                    .aspectRatio(contentMode: .fit)

                VStack(alignment: .leading,  spacing: 10){
                    Text(card.name)
                        .fontWeight(.bold)
                    

                    Text(customisedCardNumber(number: card.cardNumber))
                        .font(.callout)
                        .fontWeight(.bold)
                }
                .padding()
                .padding(.bottom,10)
                //.foregroundColor(.white)
            }
            .offset(y: expandCards ? offset : -rect.minY + offset)
        }
        .frame(height: 200)
    }
    
    func getIndex(Card: Card)->Int{
        return vm.cards.firstIndex{
            currentCard in
            return currentCard.id == Card.id
        } ?? 0
    }
    
}

func customisedCardNumber(number: String)->String{
    var newValue: String = ""
    let number = "0000 00" + number
    let maxCount = number.count - 4
    
    number.enumerated().forEach { value in
        if value.offset >= maxCount{
            
            let string = String (value.element)
            newValue.append(contentsOf: string)
        }else{
            
            let string = String(value.element)
            if string == " "{
                
                newValue.append(contentsOf: " ")
            }else{
                newValue.append(contentsOf: "*")
            }
            
        }
       
    }
    return newValue
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct DetailView: View{
    var currentCard: Card
    @Binding var showDetailCard: Bool
    
    var  animation: Namespace.ID
    
    @State var showExpenseView: Bool = false
    var body: some View{
        
     
        VStack{
           
            NavigationStack{
                ScrollView{
                HStack{
                    
                    NavigationLink{ProfileStudent(currentCard: currentCard)} label: {
                        
                        HStack{
                            Spacer()
                            Image(systemName: "gearshape")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                    .padding()
                    
                    Spacer()
                }
            }
                CardView()
                    .matchedGeometryEffect(id: currentCard.id, in: animation)
                    .frame(height: 190)
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            showExpenseView = false
                            
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                            withAnimation(.easeInOut(duration: 0.35)){
                                showDetailCard = false
                            }
                        }
                        
                        
                    }
                    .zIndex(10)
                
                GeometryReader{proxy in
                    let height = proxy.size.height + 50
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 20){
                            ForEach(expenses){expense in
                                
                                ExpenseCardView(expense: expense)
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.secondary
                            .clipShape((RoundedRectangle(cornerRadius: 25, style: .continuous)))
                            .opacity(0.3)
                            .ignoresSafeArea()
                    )
                    .offset(y: showExpenseView ? 0 : height)
                }
                //
                .padding([.horizontal,.top])
                .zIndex(-10)
            }.tint(.primary)
        }
       
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .background(Color(.lightGray).ignoresSafeArea())
        .onAppear{
            withAnimation(.easeInOut.delay(0.1)){
                showExpenseView = true
            }
        
        }
    }
    
    @ViewBuilder
    func CardView()->some View{
      

        ZStack(alignment: .bottomLeading){
            
            
            Rectangle()
                .cornerRadius(20)
            LinearGradient(gradient: Gradient(colors: currentCard.cardColor), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                //.foregroundColor(currentCard.cardColor)
                .frame(width: 390,height: 220)
                .cornerRadius(20)
            
                .aspectRatio(contentMode: .fit)
           
            VStack(alignment: .leading,  spacing: 10){
                
                Text(currentCard.name)
                    .fontWeight(.bold)
                
                Text(customisedCardNumber(number: currentCard.cardNumber))
                    .font(.callout)
                    .fontWeight(.bold)
            }
            .padding()
            .padding(.bottom,10)
            //.foregroundColor(.white)
        }
    }
  //  }
}

struct ExpenseCardView: View{
    var expense: Expense
    @State var  showView: Bool = false
    var body: some View{
        
        HStack(spacing: 14){
            VStack(alignment: .leading, spacing:8){
                Text(expense.product)
                    .fontWeight(.bold)
                
                Text(expense.spendType)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(spacing: 8){
                Text(expense.amountSpent)
                    .fontWeight(.bold)
                //Text(Data().formatted(data: .numeric, time: .omitted))
                // .font(.caption)
                //  .foregroundColor(.gray)
                
            }
        }
        .opacity(showView ? 1 : 0)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.easeInOut(duration: 0.3) .delay(Double(getIndex()) * 0.1)){ showView = true
                }
            }
        }
    }

func getIndex()->Int{
    return expenses.firstIndex {
        currentExpense in
        return expense.id == currentExpense.id
    } ?? 0
    }
}

