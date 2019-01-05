import UIKit

var avalibleParkingLot: [String] = ["","","","","","","","","",""]

var lastTicketNumber = 0

func manageParking(input: String) -> String {
    
    let actions: [String] = input.components(separatedBy: ";")
    for action in actions {
        let actionType = action.first!
        switch actionType {
        case "p":
            print("parking")
            lastTicketNumber = lastTicketNumber == 0 ? 5000 : lastTicketNumber+1
            let carLicence = String(action.dropFirst())
            parkACar(ticket: "\(lastTicketNumber)", carLicence: carLicence)
        case "u":
            print("unparking")
            let ticketNumber = String(action.dropFirst())
            unParkACar(ticket: ticketNumber)
        default:
            print("compaque")
            compactParking()
        }
    }
    return returnOutput()
}

func parkACar(ticket: String, carLicence: String) {
    let carDetail = ticket + " " + carLicence
    print(carDetail)
    for (index, lot) in avalibleParkingLot.enumerated() {
        if lot.isEmpty {
            avalibleParkingLot.remove(at: index)
            avalibleParkingLot.insert(carDetail, at: index)
            break
        }
    }
}

func unParkACar(ticket: String) {
    for (index, lot) in avalibleParkingLot.enumerated() {
        if lot.contains(ticket) {
            avalibleParkingLot.remove(at: index)
            avalibleParkingLot.insert("", at: index)
            break
        }
    }
}

func compactParking() {
    avalibleParkingLot = avalibleParkingLot.filter{ !$0.isEmpty }
    for _ in avalibleParkingLot.count..<10 {
        avalibleParkingLot.append("")
    }
}

func returnOutput() -> String {
    var outputString = ""
    for (_, lot) in avalibleParkingLot.enumerated() {
        let carLicence = lot.components(separatedBy: " ").last ?? ""
       outputString = outputString + carLicence + ","
    }
    return outputString
}


print(manageParking(input: "pABC;pCDE;pEFG;u5000;pGHI;pJKL;pKLM;pNOP;pOPQ;pQRS;u5004;u5007;c;pNOP;pOPQ;pQRS"))
