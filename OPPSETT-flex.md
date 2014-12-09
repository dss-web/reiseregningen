# Oppsett av utviklingsplattform – Adobe Flex

Applikasjonen er utviklet med ​Adobe Flex 3 Builder og denne beskrivelsen vil i all hovedsak dreie seg om oppsett i denne. Det finnes alternativer til Adobe Flex, men disse vil ikke bli dekket her. Løsningen er basert på Cairngorm arkitektur (versjon 2.2.1), en open-source arkitektur som kan lastes ned gratis fra nettet.

## Nødvendige ressurser
Adobe Flex 3: ​http://www.adobe.com/products/flex/
Cairngorm: ​http://opensource.adobe.com/wiki/display/cairngorm/Downloads
Kildekode: Subversion repository: https://www.coderesort.com/svn/reiseregningen
Når de nødvendige ressursene er lastet ned kan Adobe Flex startes for å opprette et nytt prosjekt.

## Oppsett i Adobe Flex
Følgende oppskrift bør følges for å sette opp Reiseregningsprosjektet riktig:

### Importer prosjektet
1. Velg File – Import – Flex project fra menylinjen.
1. Velg Project folder valget under Import project from.
1. Browse etter lokasjonen du har lasted ned kildekoden fra Subversion. Flex prosjektet ligger under trunk\app.
1. Klikk på Finish-knappen, prosjektet blir så importert.

### Oppsett for Cairngorm
1. Høyreklikk på rotnoden for prosjektet i Flex Navigator og velg Properties
1. Velg Flex Build Path fra menyen på venstre side
1. Velg Library path fanen i skjermbildet som dukker opp
1. For å legge til Cairngorm til prosjektet, klikk Add SWC-knappen
1. Browse etter lokasjonen du har lastet ned Cairngorm og velg Cairngorm.swc filen (lokalisert under \Cairngorm2_2_1-bin\bin\ katalogen)

### Oppsett for AutoScroll SWC
1. Løsningen benytter en AutoScroll-løsning lokalisert i LibAutoScroll.swc. For å legge til denne, klikk Add SWC-knappen1. 
1. Browse etter lokasjonen for ditt nylig importerte prosjekt og velg LibAutoScroll.swc filen i src mappen

### Oppsett for Skins SWC
1. Løsningen benytter en swc-fil for skinning av applikasjonen. For å legge til denne, klikk Add SWC-knappen
1. Browse etter lokasjonen for ditt nylig importerte prosjekt og velg flex_skins.swc filen i src\assets mappen
1. Lukk Properties-vinduet ved å klikke på OK-knappen

### Resterende oppsett
1. Høyreklikk på rotnoden for prosjektet i Flex Navigator og velg New – Folder
1. Navngi folderen libs

### Bruk av Font i løsningen
Reiseregningsapplikasjonen benytter seg av fonttypen Helvetica Neue. Dersom denne fonten ikke er installert i ditt system vil Flex etterspørre den. Du kan da velge å skaffe deg denne fonten eller bruke en annen font. Du kan endre dette i css-filen source:/trunk/app/src/assets/reiseregning.css.

## Generelt
Reiseregning-løsningen er bygget på Flex 3.x SDK. Sjekk hva din Adobe Flex versjon kompilerer mot i prosjektets Properties under Flex Compiler

Prosjektet skal nå være satt opp riktig og du kan prøve å kompilere applikasjonen.