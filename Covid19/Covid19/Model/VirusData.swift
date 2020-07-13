//
//  VirusData.swift
//  Covid19
//
//  Created by Kate Vu (Quyen) on 5/6/20.
//  Copyright © 2020 Kate Vu (Quyen). All rights reserved.
//

import Foundation

class VirusData {
    var virusInfor: [VirusInfor] = []
    
    init() {
        self.virusInfor.append(VirusInfor("What is COVID-19", "Coronaviruses are a large family of viruses that cause respiratory infections. These can range from the common cold to more serious diseases.\n\nCOVID-19 is a disease caused by a new form of coronavirus. It was first reported in December 2019 in Wuhan City in China.\n\nOther coronaviruses include Middle East Respiratory Syndrome (MERS) and Severe Acute Respiratory Syndrome (SARS).\n\nSource: Australia Government Departure of Health"))

        self.virusInfor.append(VirusInfor("Symptoms","Symptoms of COVID-19 can range from mild illness to pneumonia. Some people will recover easily, and others may get very sick very quickly. People with coronavirus may experience symptoms such as:\n\u{2022}Fever\n\u{2022}Respiratory symptoms(coughing, sore throat, shortness of breath)\n\nOther symptoms can include runny nose, headache, muscle or joint pains, nausea, diarrhoea, vomiting, loss of sense of smell, altered sense of taste, loss of appetite and fatigue.\n\nSource: Australia Government Departure of Health"))


        self.virusInfor.append(VirusInfor("How it spreads","The virus can spread from person to person through:\n\u{2022}Close contact with an infectious person (including in the 48 hours before they had symptoms)\n\u{2022}Contact with droplets from an infected person’s cough or sneeze\n\u{2022}Touching objects or surfaces (like doorknobs or tables) that have droplets from an infected person, and then touching your mouth or faceCOVID-19 is a new disease, so there is no existing immunity in our community. This means that COVID-19 could spread widely and quickly.\n\nSource: Australia Government Departure of Health"))
        
        self.virusInfor.append(VirusInfor("Who is most at risk","In Australia, the people most at risk of getting the virus are:\n\u{2022}travellers who have recently been overseas\n\u{2022}those who have been in close contact with someone who has been diagnosed with COVID-19\n\u{2022}people in correctional and detention facilities\n\u{2022}people in group residential settings\n\u{2022}People who are, or are more likely to be, at higher risk of serious illness if they get the virus are:\n\nAboriginal and Torres Strait Islander people 50 years and older with one or more chronic medical conditions\n\u{2022}people 65 years and older with chronic medical conditions\n\u{2022}people 70 years and older\n\u{2022}people with chronic conditions or compromised immune systems\n\u{2022}people in aged care facilities\n\u{2022}people with a disability\n\nAt this stage the risk to children and babies, and the role children play in the transmission of COVID-19, is not clear. However, there has so far been a low rate of confirmed COVID-19 cases among children, relative to the broader population.\n\nThere is limited evidence at this time regarding the risk in pregnant women.\n\nSource: AustraliaGovernmentDeparture of Health"))
            
        self.virusInfor.append(VirusInfor("How to seek medical attention","If you are sick and think you have symptoms of COVID-19, seek medical advice. If you want to talk to someone about your symptoms, call the National Coronavirus Helpline for advice.\n\nNational Coronavirus Helpline\nCall this line if you are seeking information on coronavirus (COVID-19) or help with the COVIDSafe app. The line operates 24 hours a day, seven days a week.\n1800 020 080\n\nSource: Australia Government Departure of Health"))
    }
}
