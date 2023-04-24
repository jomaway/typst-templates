#import "../templates/exam.typ": *

#show: exam.with(
    kind: "Schulaufgabe",  // Schulaufgabe | Stegreifaufgabe | Kurzarbeit
    date: "25.04.2023",
    class: "12b",
    subject: "IT-Systeme", 
    authors: ("JM"),
    aids: "TR", // Hilfsmittel default: none else takes a string. -> "TR",
    lsg: false,
)

#task([
    Sie sind der neue Netzwerkadministrator bei der Speed GmbH. 
    (_Hinweis:_ Netzplan im Anhang.)
])
//#image("images/ITS-11_SA-Netzplan.png")

Ein Mitarbeiter meldet, dass er mit seinem Client nicht ins Internet kommt. Bei der Überprüfung der IP-Konfiguration bekommen Sie folgende Ausgabe:
```
IP: 192.168.0.23
SNM: 255.255.255.0
GW: 192.168.0.250
```

#question(points: 2)[Begründen Sie welcher Fehler hier vorliegt und wie sie Ihn beheben.]
#lines(3)

#question(points: 1)[Ein Test zeigt, dass der Mitarbeiter trotz falscher Konfiguration drucken kann. \ Erklären Sie warum das Drucken trotz falscher Konfiguration möglich ist.]
#lines(3)

#box()[
Aufgrund von sporadisch auftretenden Netzwerkproblemen untersuchen sie die Routingtabelle des Routers. Die Ausgabe enthält folgende Einträge.
#table(
    columns: (1fr, 1fr, 1fr, 1fr),
    [*Zielnetzwerk*], [*Subnetzmaske*],[*Schnittstelle*],[*Next Hop*],
    [C 192.168.0.0],[255.255.255.0], [LAN], [-],
    [C 212.12.12.8],[255.255.255.248], [DMZ], [-],
    [C 172.19.0.0],[255.255.192.0], [WLAN], [-],
    [C 212.17.94.16],[255.255.255.252], [SDSL], [-],
    [S 0.0.0.0],[0.0.0.0], [SDSL], [212.17.94.17.30]
)
]

#question(points: 2)[
Erläutern Sie, was der letzte Eintrag bewirkt, und welches Problem auftritt, wenn dieser gelöscht wird.
] #lines(4)

// ---- AUFGABE 2 -----
#pagebreak()
#task([])
In der Routingtabelle wurde kein Fehler gefunden. Im nächsten Schritt untersuchen Sie die Übersetzung der Netzwerkadressen am Router.

#question(points: 1)[
Geben Sie die Technik (genauer Begriff) an, mit welcher sichergestellt wird, dass Kunden aus dem Internet auf die beiden Server in der DMZ (Webserver & Datenbankserver) der Speed GmbH zugreifen können.
] #lines(1)


#show "L1": set text(fill: rgb("A680B8"), weight: 700)
#show "L2": set text(fill: rgb("A680B8"), weight: 700)

Ein Mitarbeiter der Speed GmbH öffnet an seinem Laptop die Webseite eines Subunternehmers. Das am Laptop abgesendete Paket beinhaltet folgende Werte. (Stelle L1 im Netzplan)

#table(
    columns: (1fr, 1fr, 1fr, 1fr),
    [*Quell-IP*], [*Ziel-IP*],[*Quell-Port*],[*Ziel-Port*],
    [172.19.33.18],[80.17.90.12], [30237], [80],
)

#question(points: 2)[Geben Sie an, welche IP-Adressen das Paket nach passieren des Routers (Stelle L2 im Netzplan) enthält.]

#table(
    columns: (1fr, 1fr, 1fr, 1fr),
    rows: (auto, 10mm),
    align: horizon,
    [*Quell-IP*], [*Ziel-IP*],[*Quell-Port*],[*Ziel-Port*],
    [],[], [63230], [80],
)

#question(points:2)[
    Erklären Sie welcher Prozess auf dem Router stattgefunden hat und welche Informationen der Router dabei abspeichern muss, um eine Antwort auf das Paket korrekt zu verarbeiten.
] #lines(4)


#question(points:4)[Geben Sie die Werte der Antwort auf den oben gesendeten HTTP-Request an.]

Vor erreichen des Routers R1 (Stelle L2 im Netzplan)

#table(
    columns: (1fr, 1fr, 1fr, 1fr),
    rows: (auto, 10mm),
    align: horizon,
    [*Quell-IP*], [*Ziel-IP*],[*Quell-Port*],[*Ziel-Port*],
    [],[], [], [],
)

Nach erreichen des Routers R1 (Stelle L1 im Netzplan)

#table(
    columns: (1fr, 1fr, 1fr, 1fr),
    rows: (auto, 10mm),
    align: horizon,
    [*Quell-IP*], [*Ziel-IP*],[*Quell-Port*],[*Ziel-Port*],
    [],[], [], [],
)

// ---- AUFGABE 3 -----
#pagebreak()
#task([
    Im Rahmen der Reorganisation der IT-Infrastruktur der Speed GmbH sollen Sie die Netzwerksicherheit gewährleisten und den Regelsatz der Firewall analysieren und erweitern.
])

#question(points:3)[Erklären Sie, was eine DMZ in Bezug auf Netzwerksicherheit bedeutet und wie sie eingesetzt wird. Geben Sie auch ein Beispiel für eine Situation, in der die Verwendung einer DMZ sinnvoll ist] #lines(6)

Auf der Firewall sind die ersten beiden Regeln die folgenden:

#block[ 
    #set text(10pt) 
    #table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: horizon,
    text(9pt, "Nr"), [*Aktion*], [*Protokoll*], [*Quelle*], [*Ziel*], [*Quell-Port*],[*Ziel-Port*], [*Interface*], [*Richtung*],
    "1","Accept", "TCP", "any", "Webserver", ">1023", "80", "SDSL", "IN",
    "2","Accept", "TCP", "any", "Webserver", ">1023", "443", "SDSL", "IN",
    "3","", "", "", "", "", "", "", "",
    )
    #align(end)[
        #set text(9pt);
        _Hinweis:_ Webserver in der DMZ aus dem Netzwerkplan.
    ]
]

#question(points: 2)[Erläutern Sie die Regeln 1 und 2.]

#table(
    columns: (auto, 1fr),
    rows: 20mm,
    align: horizon,
    "1", "",
    "2", "",
)

#question(points: 2)[Schreiben Sie die letzte Regel für die Firewall, die alle eingehenden Verbindungen verbietet, die nicht durch eine vorherige Regel erlaubt wurden.]

#block[ 
    #set text(10pt) 
    #table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    rows: (auto, 15mm),
    align: horizon,
    text(8pt, "Nr"), [*Aktion*], [*Protokoll*], [*Quelle*], [*Ziel*], [*Quell-Port*],[*Ziel-Port*], [*Interface*], [*Richtung*],
    "9","", "", "", "", "", "", "", "",
    )
]


#question(points:4)[Auf dem Router ist eine Firewall eingerichtet, die nach dem Prinzip einer Stateful Packet Inspection (SPI) arbeitet. Erläutern Sie das Arbeitsprinzip der Stateful Packet Inspection im Unterschied zum reinen Paketfilter.]
#lines(4)

#pagebreak()
#task[
    Die Konfiguration der Firewall wird über das Command Line Interface (CLI) des Routers vorgenommen.
]

#show raw: set block(inset: 1em, fill: gray.lighten(50%), radius: 0.2em, width: 100%)

#question(points:2)[Welche Art von ACLs würden sie verwenden - Standard oder Extended? Begründen Sie Ihre Antwort und geben Sie an, welche Unterschiede zwischen Standard und Extended ACLs bestehen.]
#lines(4)


Im Rahmen der Konfiguration wird folgender Befehl ausgeführt.
```bash
RT1(config-ext-nacl)# deny tcp host 192.168.0.12 host 212.12.12.9 eq 80
```

#question(points: 2)[
    Beschreiben Sie was der Befehl macht.
] #lines(4)

Nach der erfolgreichen Konfiguration, werden noch die folgenden beiden Befehle abgesetzt.
```bash
    RT1(config)# interface g0/0
    RT1(config-f)# ip access-group LIST_ONE in
```
#question(points: 2)[
     Erklären Sie, warum diese notwendig sind.
] #lines(4)


#v(1fr)



#align(end)[
    #set text(14pt)
    #box(stroke: 1pt, inset: 0.8em)[
        #align(start)[*Gesamt*:]  \_\_\_ \/ #total_points.display() #smallcaps("PT")
    ]
]

#goodluck


