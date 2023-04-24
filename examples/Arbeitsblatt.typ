#import "../templates/worksheet.typ": *

#show: worksheet.with(
    topic: "Lernsituation - Routing / Firewall",  
    subject: "IT-Systeme", 
    authors: ("JM", "VB", "JL"),
    version: "0.3",
    lsg: false,
)

= Einführung

#lorem(150)


#colorbox(title: "Merke", color: "red")[#lorem(40)]

= Grundlagen 

== Aufbau einer Firewall

#lorem(50)

#taskbox(title: "Überlegen Sie")[
+ An welcher Stelle würden Sie den Webserver ins Netzwerk einbinden?
+ Was bedeutet das für die Sicherheit ihres Netzwerkes? 
]

#lorem(60)

#colorbox(title: "Analogie")[Die Firewall agiert wie ein „Türsteher“ , der entscheidet wer in den Club rein kommt
und wer draußen bleiben muss.]

== Angriffe aus den eigenen Reihen

#merke[Eine Firewall hilft nicht gegen *Angriﬀe* aus den eigenen Reihen.]


#infobox[Hier endet die Demo]