#import "../templates/exam.typ": *

#show: exam.with(
    kind: "Schulaufgabe",  // Schulaufgabe | Stegreifaufgabe | Kurzarbeit
    date: datetime(year: 2023, month: 6, day: 7),  // datetime or string -> "7.6.2023",
    class: "IT 99x",
    subject: "IT-Systeme",
    aids: "Taschenrechner",
    lsg: false,  // change this to true to see the solutions    
    print_cover: true,  // Print a cover page
)

= Aufbau eines Local Area Networks // You can use heading syntax to create a new task.

Sie sollen im Rahmen eines Projektes das LAN im neuen Schulungsraum aufbauen. \
Dazu müssen neue Netzwerkkompenenten bestellt und konfiguriert werden.

#question(points: 4)[*Erläutern* Sie den *Unterschied* zwischen aktiven und passiven Netzwerkkompenenten und geben Sie jeweils *ein Beispiel* an.]
aktiv #sym.arrow.r #solution(placeholder: lines(2))[mit Stromverbindung z.B. Switch/Router]

passiv #sym.arrow.r #solution(placeholder: lines(2))[ohne Stromverbindung z.B. Leitungen]

#question(points: 3)[Geben Sie *3 Kriterien* an, die bei der Vergabe von IP-Adressen *im gleichen LAN* beachtet werden müssen.]
#solution(placeholder: lines(6))[
    - Keine IP doppelt vergeben
    - Broadcast und Netzwerkadresse dürfen nicht an Hosts vergeben werden.
    - Alle Geräte brauchen den gleichen Netzanteil / Subnetzmaske.
]

#question(points: 3)[Es müssen 31 Host adressiert werden. Berechnen (_Rechenweg_) Sie die *Subnetzmaske* (_Angabe in dezimal_) passend zur Anzahl der benötigten Hosts. Geben Sie die Subnetzmaske in *dezimaler* und *CIDR-Notation*. an]
*Rechenweg:*
#solution(placeholder: lines(5))[
    $2⁵-2=32-2=30$ adressierbare Host #sym.arrow.r zu wenig!
    $2⁶-2 = 64-2 = 62 $ addressierbare Hosts. Daher werden 6 Hostbits benötigt. $32-6=26$ #sym.arrow.r `/26` Subnetzmaske.
    Umrechnung in Dezimal im letztes Oktet: `1100 0000`#sub[(bin)] = `192`#sub[(dez)]
]
#grid(
    columns: (auto,1fr,auto,1fr),
    [*dezimal:*], solution(placeholder: align(bottom)[#h(0.4em) #lines(1) #h(0.4em)])[`255.255.255.192`], [*CIDR-Präfix:*], solution(placeholder: align(bottom)[#h(0.4em) #lines(1) #h(0.4em)])[`\26`]
)

#pagebreak()
#task(points: 5)[Kreuzen Sie die richtige Lösung an.]
#set text(14pt)

== Welche Adresse ist eine *Broadcast*-Adresse?
#let addr = (`201.55.255.155/26`, `23.255.223.127/26`, `1.255.25.128/26`, `192.223.240.65/26`, `10.255.0.255/12`)
#mct(choices:addr, answer:2)

== Welche *Netz*-Adresse ist *ungültig*?    
#let addr = (`25.240.0.0/15`, `125.255.24.0/23`, `195.196.197.240/28`, `215.1.2.221/25`, `24.0.0.0/24`)
#mct(choices:addr, answer:4)

== Welche Adresse ist eine *gültige Host*-Adresse?    
#let addr = (`16.63.255.255/24`, `126.128.0.0/16`, `16.127.255.255/8`, `95.0.0.0/24`, `13.130.254.255/28`)
#mct(choices:addr, answer:3)

== Welche Host-Adresse liegt *im Netzwerk* `207.248.255.0/24`?
  #let addr = (`207.249.255.1`, `207.248.254.255`, `207.248.253.0`, `207.248.255.245`, `207.248.255.255`)
  #mct(choices:addr, answer:4)

= Letzte Aufgabe

#question(points: 85)[nothing]