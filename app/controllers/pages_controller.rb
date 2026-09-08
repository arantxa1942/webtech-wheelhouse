class PagesController < ApplicationController
    def home 
    end 

    def services
        @services=[
            {name: "brake or gear adjustment", price:"$10.000" },
            {name: "Installation of accessories", price: "$15.000"},
            {name: "wheel truing", price: "$10.000"},
            {name: "minor mechanical repairs", price: "$10.000"},
            {name: "chain installation", price:"$4.000"},
            {name: "handler installation", price: "$4.000"},
            {name: "bike wash",price:"$18.000"},
            {name: "wheel assembly",price:"$20.000"},
            {name: "Insert Installation (each wheel)", price: "$3.000"},
            {name: "Bicycle Assembly", price:"$20.000"},
            {name: "Complete Transmission Installation", price:"$10.000"},
            {name: "Sprocket/Cassette Installation", price:"$4.000"},

        ]
    end 
    def visit 
    end 

    def about 
    end 

end 