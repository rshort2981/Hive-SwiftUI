import SwiftUI

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var vm = ViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Total Price", text: $vm.data.checkAmount, onEditingChanged: {isEdited in
                        vm.isEdited = isEdited
                    }).keyboardType(.decimalPad)

                    Picker("\(Image(systemName: "person.fill")) People", selection: $vm.data.numberOfPeople) {
                        ForEach(1 ..< 100){ Text("\($0)") }
                    }
                }
                .listRowBackground(vm.background(colorScheme: colorScheme))

                Section(header: Text("Tip")) {
                    Picker("Tip Percentage", selection: $vm.data.tipPercentage) {
                        ForEach(0..<vm.data.tipPercentages.count) {
                            Text("\(vm.data.tipPercentages[$0])%")
                                .foregroundColor(vm.data.tipPercentage == $0 ? .blue : .primary)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 75, alignment: .center)

                    Text("Tip: $\(vm.tipAmount, specifier: "%.2f")")
                        .listRowBackground(vm.background(colorScheme: colorScheme))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.gray)
                        .font(.custom("Poppins-Regular", size:18))
                }
                .listRowBackground(vm.background(colorScheme: colorScheme))

                DisplaySection(function: vm.showTotal())
                DisplaySection(function: vm.showCostEach())
                DisplaySection(function: vm.showSavings())
            }
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0) {
                        Image(systemName: "ant.fill").font(.title2).foregroundColor(.orange)
                        Text("Hive").font(.custom("Poppins-Bold", size:34)).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            .background(vm.background(colorScheme: colorScheme)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
        }
        .gesture(TapGesture().onEnded({
                    UIApplication.shared.windows.first{$0.isKeyWindow }?.endEditing(true)
        }), including: vm.isEdited ? .all : .none)
    }
}
