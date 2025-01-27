//
//  main.swift
//  Final_Gagandeep
//
//  Created by Gagandeep Kaur on 2025-01-22.
//

import Foundation

print("Hello, World!")

//Create PropertyDescrip&on protocol that consist of a method which shows all the informa:on
//about property.
//- This protocol must be conformed to in Residen:al and Commercial property classes.
//- This protocol should also have a method that calculates and displays commission (5%)
//on the property’s selling price.

protocol PropertyDescription {
    func displayDetails()
    func calculateAndDisplayCommission()
}

class Property{
    var propertyID: Int
    var address: String
    var area: Double
    var sellingPrice: Int
    var sellingAgent: String?
    
    init?(propertyID: Int, address: String, area: Double, sellingPrice: Int, sellingAgent: String?) {
            if propertyID > 0 {
                self.propertyID = propertyID
            } else {
                print("Error: Property ID must be greater than 0.")
                return nil
            }
            
            if !address.isEmpty {
                self.address = address
            } else {
                print("Error: Address cannot be empty.")
                return nil
            }
            
            if area > 0 {
                self.area = area
            } else {
                print("Error: Area must be greater than 0.")
                return nil
            }
            
            if sellingPrice >= 0 {
                self.sellingPrice = sellingPrice
            } else {
                print("Error: Selling price cannot be negative.")
                return nil
            }
            
            // Selling agent is optional, so no validation needed
            self.sellingAgent = sellingAgent
        }
        
        // Method to display property details
        func displayDetails() {
            print("Property Details:")
            print("ID: \(propertyID)")
            print("Address: \(address)")
            print("Area: \(area) sq.ft.")
            print("Selling Price: $\(sellingPrice)")
            print("Selling Agent: \(sellingAgent ?? "None")")
        }
}

class ResidentialProperty: Property, PropertyDescription {
    var numberOfBedrooms: Int
    var numberOfBathrooms: Int
    var propertyType: String

    init?(
        propertyID: Int,
        address: String,
        area: Double,
        sellingPrice: Int,
        sellingAgent: String?,
        numberOfBedrooms: Int,
        numberOfBathrooms: Int,
        propertyType: String
    ) {
        // Validate subclass-specific properties
        if numberOfBedrooms <= 0 {
            print("Error: Number of bedrooms must be greater than 0.")
            return nil
        }
        if numberOfBathrooms <= 0 {
            print("Error: Number of bathrooms must be greater than 0.")
            return nil
        }
        if propertyType.isEmpty {
            print("Error: Property type cannot be empty.")
            return nil
        }
        // Initialize subclass-specific properties
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathrooms = numberOfBathrooms
        self.propertyType = propertyType

        // Call the superclass initializer
        super.init(
            propertyID: propertyID,
            address: address,
            area: area,
            sellingPrice: sellingPrice,
            sellingAgent: sellingAgent
        )
    }

    override func displayDetails() {
        super.displayDetails()
        print("Number of Bedrooms: \(numberOfBedrooms)")
        print("Number of Bathrooms: \(numberOfBathrooms)")
        print("Property Type: \(propertyType)")
    }
    func calculateAndDisplayCommission(){
        let Commission = Double(sellingPrice) * 0.05
        print( "Commission: \(Commission)")
    }
}

class CommercialProperty: Property {
    var numberOfShelves: Int
    var numberOfExits: Int
    var numberOfStoreys: Int
    var propertyType: String

    init?(
        propertyID: Int,
        address: String,
        area: Double,
        sellingPrice: Int,
        sellingAgent: String?,
        numberOfShelves: Int,
        numberOfExits: Int,
        numberOfStoreys: Int,
        propertyType: String
    ) {
        // Validate subclass-specific properties
        if numberOfShelves < 0 {
            print("Error: Number of shelves cannot be negative.")
            return nil
        }
        if numberOfExits <= 0 {
            print("Error: Number of exits must be greater than 0.")
            return nil
        }
        if numberOfStoreys <= 0 {
            print("Error: Number of storeys must be greater than 0.")
            return nil
        }
        if propertyType.isEmpty {
            print("Error: Property type cannot be empty.")
            return nil
        }

        // Assign subclass-specific properties
        self.numberOfShelves = numberOfShelves
        self.numberOfExits = numberOfExits
        self.numberOfStoreys = numberOfStoreys
        self.propertyType = propertyType

        // Call the superclass initializer using `if let`
        if let superInit = Property(
            propertyID: propertyID,
            address: address,
            area: area,
            sellingPrice: sellingPrice,
            sellingAgent: sellingAgent
        ) {
            super.init(
                propertyID: superInit.propertyID,
                address: superInit.address,
                area: superInit.area,
                sellingPrice: superInit.sellingPrice,
                sellingAgent: superInit.sellingAgent
            )
        } else {
            print("Error: Failed to initialize superclass Property.")
            return nil
        }
    }

    override func displayDetails() {
        super.displayDetails()
        print("Number of Shelves: \(numberOfShelves)")
        print("Number of Exits: \(numberOfExits)")
        print("Number of Storeys: \(numberOfStoreys)")
        print("Property Type: \(propertyType)")
    }
    func calculateAndDisplayCommission() {
        let commission = Double(sellingPrice) * 0.05
        print("Commission (5%): $\(commission)")
    }
}

class Agent {
    var agentID: Int
    var name: String
    var email: String
    var propertiesForSale: [Property] = []
    var propertiesToBuy: [Property] = []
    var commissionEarned: Double = 0.0
    
    init?(agentID: Int, name: String, email: String) {
        if agentID <= 0 {
            print("Error: Agent ID must be greater than 0.")
            return nil
        }
        if name.isEmpty {
            print("Error: Name cannot be empty.")
            return nil
        }
        if !email.contains("@") || email.isEmpty {
            print("Error: Invalid email address.")
            return nil
        }
        self.agentID = agentID
        self.name = name
        self.email = email
    }
        func sellProperty(_ property: Property) {
            if propertiesToBuy.contains(where: { $0.propertyID == property.propertyID }) {
                print("Error: Agent cannot sell a property they are buying.")
                return
            }
            propertiesForSale.append(property)
            print("Property \(property.propertyID) added to selling list.")
        }
        
        func buyProperty(_ property: Property) {
            if propertiesForSale.contains(where: { $0.propertyID == property.propertyID }) {
                print("Error: Agent cannot buy a property they are selling.")
                return
            }
            propertiesToBuy.append(property)
            print("Property \(property.propertyID) added to buying list.")
        }
        
        func calculateCommission(property: Property) -> Double {
            let commission = Double(property.sellingPrice) * 0.05
            commissionEarned += commission
            return commission
        }
        func displayDetailsOfAgent() {
            print("Agent Details:")
            print("ID: \(agentID)")
            print("Name: \(name)")
            print("Email: \(email)")
            print("Properties for Sale:")
            for property in propertiesForSale {
                print("- ID: \(property.propertyID), Address: \(property.address), Price: $\(property.sellingPrice)")
            }
            print("Properties to Buy:")
            for property in propertiesToBuy {
                print("- ID: \(property.propertyID), Address: \(property.address), Price: $\(property.sellingPrice)")
            }
            print("Total Commission Earned: $\(commissionEarned)")
        }
}

class Manager {
    var properties: [Property] = []
    
    func addProperty(_ property: Property) {
        properties.append(property)
        print("Property \(property.propertyID) added successfully.")
    }
    
    func updateProperty(_ propertyID: Int, newAddress: String?, newArea: Double? ,newSellingPrice: Int?,newAgent: String? ){
        if let propertyIndex = properties.firstIndex(where: { $0.propertyID == propertyID }) {
            if let newAddress = newAddress { properties[propertyIndex].address = newAddress }
            if let newArea = newArea { properties[propertyIndex].area = newArea }
            if let newSellingPrice = newSellingPrice { properties[propertyIndex].sellingPrice = newSellingPrice }
            if let newAgent = newAgent { properties[propertyIndex].sellingAgent = newAgent }
            print("Property \(propertyID) updated successfully.")
        } else {
            print("Error: Property with ID \(propertyID) not found.")
        }
    }
    
    func removeProperty(_ propertyID:Int){
        if let propertyIndex = properties.firstIndex(where: {$0.propertyID == propertyID}){
            properties.remove(at: propertyIndex)
            print(propertyID,"Property removed successfully.")
        }
        else {
            print("Error: Property with ID \(propertyID) not found.")
        }
    }
    
    func assignAgent(_ propertyID: Int, _ agentName: String) {
        if let propertyIndex = properties.firstIndex(where: { $0.propertyID == propertyID }) {
            properties[propertyIndex].sellingAgent = agentName
            print("Agent \(agentName) assigned to property \(propertyID) successfully.")
        } else {
            print("Error: Property with ID \(propertyID) not found.")
        }
    }
    func searchProperties(propertyType: String? = nil, address: String? = nil, price: Int? = nil) -> [Property] {
        return properties.filter { property in
            var matchesType = true
            var matchesAddress = true
            var matchesPrice = true
            
            if let type = propertyType {
                if let residentialProperty = property as? ResidentialProperty {
                    matchesType = residentialProperty.propertyType.lowercased() == type.lowercased()
                } else if let commercialProperty = property as? CommercialProperty {
                    matchesType = commercialProperty.propertyType.lowercased() == type.lowercased()
                } else {
                    matchesType = false
                }
            }
            
            if let addr = address {
                matchesAddress = property.address.lowercased().contains(addr.lowercased())
            }
            
            if let price = price {
                matchesPrice = property.sellingPrice <= price
            }
            
            return matchesType && matchesAddress && matchesPrice
        }
    }
    func displayAllProperties() {
        if properties.isEmpty {
            print("No properties available.")
        } else {
            for property in properties {
                property.displayDetails()
                print("-------------")
            }
        }
    }
}

// unwraping residentialProperty

//if let residentialProperty = ResidentialProperty(
//    propertyID: 22,
//    address: "123 Elm Street",
//    area: 1200,
//    sellingPrice: 250000,
//    sellingAgent: "Alice Johnson",
//    numberOfBedrooms: 3,
//    numberOfBathrooms: 2,
//    propertyType: "Detached"
//) {
//    residentialProperty.displayDetails()
//    residentialProperty.calculateAndDisplayCommission()
//} else {
//    print("Failed to create residential property due to invalid data.")
//}

// unwraping CommercialProperty
//if let commercialProperty = CommercialProperty(
//    propertyID: 201,
//    address: "456 Maple Street",
//    area: 3000,
//    sellingPrice: 800000,
//    sellingAgent: "Bob Smith",
//    numberOfShelves: 50,
//    numberOfExits: 3,
//    numberOfStoreys: 2,
//    propertyType: "Warehouse"
//) {
//    commercialProperty.displayDetails()
//    commercialProperty.calculateAndDisplayCommission()
//} else {
//    print("Failed to create commercial property due to invalid data.")
//}

//if let agent = Agent(agentID: 1, name: "John Doe", email: "john.doe@example.com") {
//    // unwraping property
//    if let property1 = Property(propertyID: 101, address: "456 Maple Street", area: 2000, sellingPrice: 300000, sellingAgent: "Jane Smith") {
//        agent.sellProperty(property1)
//        print("Commission: $\(agent.calculateCommission(property: property1))")
//    }
//    
//    if let property2 = Property(propertyID: 102, address: "789 Oak Avenue", area: 1500, sellingPrice: 250000, sellingAgent: nil) {
//        agent.buyProperty(property2)
//    }
//    
//    agent.displayDetailsOfAgent()
//}

// create objects of ResidentialProperty and CommercialProperty classes
let residentialProperty1 = ResidentialProperty(propertyID: 1,address: "123 Elm Street, Toronto",area: 1500,sellingPrice: 900000,sellingAgent: nil,numberOfBedrooms: 3,numberOfBathrooms: 2,propertyType: "Detached")

let residentialProperty2 = ResidentialProperty(propertyID: 2,address: "456 Maple Avenue, Toronto",area: 1800,sellingPrice: 1200000,sellingAgent: nil,numberOfBedrooms: 4,numberOfBathrooms: 3, propertyType: "Semi-Detached")
// one with invalid id
let residentialProperty3 = ResidentialProperty(propertyID: -1, address: "", area: 2000,sellingPrice: 800000,sellingAgent: nil,numberOfBedrooms: 4,numberOfBathrooms: 2,propertyType: "")

let commercialProperty1 = CommercialProperty(propertyID: 3,address: "789 King Street, Brampton",area: 3000,sellingPrice: 1500000,sellingAgent: nil,numberOfShelves: 10,numberOfExits: 2,numberOfStoreys: 1,propertyType: "Warehouse")

let commercialProperty2 = CommercialProperty(propertyID: 4,address: "101 Queen Street, Mississauga",area: 4000,sellingPrice: 2500000,sellingAgent: nil,numberOfShelves: 15,numberOfExits: 3, numberOfStoreys: 2, propertyType: "Store")

//one with Invalid id and area
let commercialProperty3 = CommercialProperty( propertyID: -1, address: "Main Street", area: -200,sellingPrice:  200000,sellingAgent: nil,numberOfShelves: 5,numberOfExits: 1,numberOfStoreys: 1,propertyType: "")

// create objects of Agent class
let agent1 = Agent(agentID: 1, name: "Alice Johnson", email: "alice@realestate.com")!
let agent2 = Agent(agentID: 2, name: "Bob Smith", email: "bob@realestate.com")!
let agent3 = Agent(agentID: 3, name: "Carol Lee", email: "carol@realestate.com")!

// create an object of Manager class
let manager = Manager()

// Assign different agents to different properties
manager.assignAgent(1, "Alice Johnson")
manager.assignAgent(2, "Bob Smith")

// Add properties to the manager's property list and sort by price
manager.addProperty(residentialProperty1!)
manager.addProperty(residentialProperty2!)
manager.addProperty(commercialProperty1!)
manager.addProperty(commercialProperty2!)

// Modify a property attribute
residentialProperty1?.sellingPrice = 850000
print("Modified property details:")
residentialProperty1?.displayDetails()

// Delete a property
manager.removeProperty(2)

// emonstrate property search
print("\nSearching properties in Toronto with price < 1M:")
let searchResults = manager.searchProperties(address: "Toronto", price: 1000000)
for property in searchResults {
    property.displayDetails()
}
agent1.sellProperty(residentialProperty1!)
agent2.buyProperty(commercialProperty1!)
agent1.buyProperty(residentialProperty1!)

let highestEarningAgent = [agent1, agent2, agent3].max(by: { $0.commissionEarned < $1.commissionEarned })
print("\nHighest Earning Agent:")
highestEarningAgent?.displayDetailsOfAgent()
