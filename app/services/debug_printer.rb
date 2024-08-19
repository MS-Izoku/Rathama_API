class DebugPrint
    def self.print (obj, header = "")
        p "==============================#{header}=============================="
        puts ""
        puts obj
        puts ""
        p "====================================================================="
    end

    
    def self.p (obj, header = "")
        p "==============================#{header}=============================="
        puts ""
        p obj
        puts ""
        p "====================================================================="
    end
end