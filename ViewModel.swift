import SwiftUI

class ViewModel:ObservableObject {
    
    @Published var data = Data(checkAmount: "",
                               numberOfPeople: 0,
                               tipPercentage: 0,
                               tipPercentages: Array(0...100).filter {$0.isMultiple(of: 5) || $0 == 0})
    
    @Published var isEdited = false
    
    func background(colorScheme: ColorScheme) -> Color {
        if colorScheme == .light {
            return Color(red: 247/255, green: 226/255, blue: 188/255)
        } else {
            return .black
        }
    }

    var tipAmount: Double {
        let tipSelection = Double(data.tipPercentages[data.tipPercentage])
        let orderAmount = Double(data.checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        
        return tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(data.numberOfPeople + 1)
        let tipSelection = Double(data.tipPercentages[data.tipPercentage])
        let orderAmount = Double(data.checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalSaved: Double {
        let peopleCount = Double(data.numberOfPeople + 1)
        let tipSelection = Double(data.tipPercentages[data.tipPercentage])
        let orderAmount = Double(data.checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        let savedTotal = grandTotal - amountPerPerson
        
        return savedTotal
    }
    
    func showTotal() -> some View {
        let orderAmount = Double(data.checkAmount) ?? 0
        let grandTotal = orderAmount + tipAmount
        
        return Text("Total: $\(grandTotal, specifier: "%.2f")")
            .font(.custom("Poppins-SemiBoldItalic", size:24))
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    
    func showCostEach() -> some View {
        let show = data.numberOfPeople > 0 ? Text("$\(totalPerPerson, specifier: "%.2f") each").font(.custom("Poppins-SemiBoldItalic", size:24)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/) : Text("")
        
        return show
    }
    
    func showSavings() -> some View {
        let show = totalPerPerson > 0.00 && data.numberOfPeople > 0 ? Text("Each saves $\(totalSaved, specifier: "%.2f")").foregroundColor(.green).font(.custom("Poppins-SemiBoldItalic", size:24)) : Text("")
        
        return show
    }
}
