
import Foundation

struct Bill: Money {
    
    var currency: Currency
    var _amount: Int
    
    init(amount: Int = 0, currency: Currency = "EUR") {
        self.currency = currency
        self._amount = amount
    }
    
    func times(_ factor: Int) -> Bill {
        return Bill(amount: _amount * factor)
    }
    
    func plus(_ addend: Bill) -> Bill {
        return Bill(amount: _amount + addend._amount)
    }
    
    func reduced(to: Currency, broker: Rater) throws -> Bill {
        let conversionRate = try broker.rate(from: currency, to: to)
        return Bill(amount: _amount * conversionRate, currency: to)
    }

}

extension Bill: Equatable {
    
    public static func ==(lhs: Bill, rhs: Bill) -> Bool {
        return lhs._amount == rhs._amount
    }

}

extension Bill: Hashable {
    
    public var hashValue: Int {
        get {
            return _amount.hashValue
        }
    }
    
}

extension Bill: CustomStringConvertible {
    public var description: String {
        get {
            return "<Bill of \(_amount) \(currency)>"
        }
    }
}
