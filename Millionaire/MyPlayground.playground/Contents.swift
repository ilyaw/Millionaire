
var str: String = ""

var test: String = "" {

    didSet {
        oldValue
    }
    willSet {
        newValue
    }
    
}

str = "111"
str
