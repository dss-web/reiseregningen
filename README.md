# Reiseregning på Web

Velkommen til utviklingsprosjektet for ​http://reiseregningen.no. Applikasjonen er utviklet for Fornyings- og administrasjonsdepartementet (FAD), og gjort tilgjengelig som åpen kildekode for bruk og gjenbruk av andre (​BSD lisens).

Reiseregningen er en applikasjon for elektronisk utfylling av reiseregninger. Hensikter:

effektivisere utfyllingen
redusere opplæringskrav
tilgjengeliggjøre løsningen på tvers av plattformer.
Løsningen er nettbasert og plattformuavhengig. Det kreves ikke installasjon på lokal maskin for å kjøre applikasjonen.

## Løsningskonsept
Screenshot av forside applikasjon.

Løsningen baserer seg på Adobe Flex teknologi. Denne teknologien ble valgt for å gi løsningen større grad av interaktivitet og fleksibilitet med bruk av en mer dynamisk teknologi enn tradisjonelle web applikasjoner. Lagring og print av reiseregninger gjøre mulig gjennom enkle WebServices som er basert på .Net teknologi.

Løsningen viser sin fleksibilitet med å kun presentere det nødvendige for brukerne i en gitt situasjon, og de blir automatisk hjulpet gjennom utfyllingen ved hjelp av innebygd logikk og utregninger basert på statens regelverk. Umiddelbare tilbakemeldinger og utfyllingshjelp skal gjøre opplæringsbehovet minimalt.

Løsningen gjør det også mulig å dele reiseregninger med f.eks. andre kollegaer som har deltatt på samme reise som en annen bruker.

Applikasjonen er bygd med tanke på tilgjengelighet for flest mulig brukergrupper. Den er plattformuavhengig og skal fungere likt i alle nettlesere. I tillegg er det lagt opp til en løsning som fungerer med skjermlesere for blinde/svaksynte brukere.

## Dokumentasjon

### Installasjonsveiledning – Flex-løsningen
Applikasjonen er en Flash-applikasjon som krever ​Flash player versjon 9.x eller høyere på klientsiden. På serversiden kan den kompilerte versjonen kopieres direkte til ønsket lokasjon på serveren. Eneste konfigurering som må til er å endre config.xml filen som ligger under resources katalogen for å koble til WebServices.

/resources/config.xml
I katalogen resources ligger config.xml. Åpne denne i et tekstediteringsprogram (Notepad, EditPlus e.l.). Erstatt alle steder hvor det nå står [insert_url_to_webservice_here] med url til der WebService for Reiseregningsapplikasjonen er installert.

For å unngå problematikk rundt cross-domain security anbefales det å legge WebServices og applikasjonen på samme domene. Dersom denne anbefalingen ikke blir fulgt må det implementering av en cross-domain xmlfil som tillater Flashapplikasjonen å kommunisere med WebServicen. Denne kommunikasjonen beskrives ikke her. Les mer om ​cross-domain policy file her.

Språkdefinisjoner
Spesifisert i config.xml filen ligger en referanse til language.xml. Her kan man legge til og fjerne språkversjoner etterhvert som flere språk gjøres tilgjengelige. Applikasjonen vil da automatisk implementere de språkene som er definert i denne filen. Se egen beskrivelse av xml-filen i resources mappen.

Andre ressurser
I resources mappen ligger det en del xml-filer som er sentrale i denne applikasjonen. To av filene er beskrevet tidligere i dette dokumentet. De resterende filene er også editerbare og det ligger en enkel beskrivelse av hver fil i resources mappen.

Ressursene som omtales gjelder satser og regler for innenlands- og utenlandsreiser, kommunenavn i Norge, postnummer/postkontor og valutakoder.

### TekniskPlattform -- for mer bakgrunnsinformasjon om teknisk løsning

Løsningen vil være tilgjengelig gjennom en nettleser og på grunn av dette vil det være påkrevd at brukerne har tilgang til Internett. Løsningen er utviklet med ​Adobe Flex 3, en teknologi som gjør den tilgjengelig i alle nettlesere og operativsystem/plattform. Flex er en utvidelse av ​Adobe Flash og krever ​Flash Player 9 eller høyere for å bli avspilt i nettleseren.

Applikasjonen krever ingen form for innlogging og kan derfor bli installert og hostet fra ethvert webserver miljø som f.eks. Windows/ISS eller Linux/Apache.

Applikasjonen kaller WebServices i DSS sitt servermiljø for lagring av reiseregninger og printing av PDF-dokumenter. Kommunikasjon med disse tjenestene løses ved hjelp av standardiserte protokoller (SOAP/HTTP).

Språk (tekst), tariffer og andre konfigurasjoner er definert i xml-filer som ligger på samme lokasjon som applikasjonen på serveren. Disse kan tilpasses av en administrator.

Flex-løsningen er bygd basert på Cairngorm arkitektur. Cairngorm er en lettvekts mikro-arkitektur for utvikling av rike internett applikasjoner bygd med Flex eller AIR.
Les mer om ​Cairngorm her.


### OppsettUtvikling -- sett opp eget utviklingsmiljø for å gjøre endringer på kildekoden

Koden består av to adskilte moduler - en Flex web applikasjon, og et sett med .NET WebServices.

* [Oppsett av utviklingsplattform – Adobe Flex](OPPSETT-flex.md)
* [Oppsett av utviklingsplattform - .NET WebServices](OPPSETT-webservice.md)

### KodeStruktur -- innføring i kildekodens organisering og struktur


Her følger en beskrivelse om hvordan strukturen til Flex-prosjektet er bygd opp.

**src**
Her ligger kildekoden til hele Flex-løsningen, samt ressursfiler, grafiske elementer og oppsett. Nærmere beskrivelse følger.

## Kildekode
Arkitekturen bak denne løsningen baserer seg på Cairngorm 2.2.1 arkitekturen. Inndeling og struktur av ActionScript kildekoden er dermed basert på dette. Kildekoden finnes under source:/trunk/app/src/no/makingwaves/cust/dss.

Hovedfilen som binder løsningen sammen ligger på rotnivået i `src` katalogen. Her finnes også de html-filene som er basis for visning av Flash-løsningen. Resterende inndeling av kode baseres på Cairngorm arkitekturen og denne beskrivelsen vil ikke gå i dybden på dette, men en kort beskrivelse følger.

**[business](app/src/no/makingwaves/cust/dss/business)**

Her ligger kildekoden som styrer selve kommunikasjonen mellom WebServices og kall mot innlastning av xml-filer som er nødvendige for løsningen. Katalogen består stort sett av såkalte Delegates som kalles fra `commands` i løsningen.

**[commands](app/src/no/makingwaves/cust/dss/commands)**

Alle kall mot WebServices og xml-filer starter med disse definerte `commands`. Det er en egen klasse for hver `command`. Disse klassene er koblet opp mot `Delegates` som ligger i `buiness` katalogen og `Events` som ligger i `events` katalogen.

**[events](app/src/no/makingwaves/cust/dss/events)**

Eventene er knyttet opp mot `commands` og er alle definert her. Events er selve triggerne mot kommunikasjon mot WebServices og xml-filer i løsningen.

**[control](app/src/no/makingwaves/cust/dss/control)**

Controller klassen knytter sammen og definerer alle `commands` og `events`.

**[model](app/src/no/makingwaves/cust/dss/model)**

ModelLocator holder alle globale verdier i løsningen.

**[view](app/src/no/makingwaves/cust/dss/view)**

Alle grensesnitt og komponenter som benyttes i løsningen er definert her.

**[vo](app/src/no/makingwaves/cust/dss/vo)**

Her er alle Value Objects som brukes i løsningen definert.

**[code](app/src/no/makingwaves/cust/dss/code)**

Her finnes applikasjonskode som ikke kan defineres under de foregående kategoriene. Her finnes bl.a. kalkuleringsrutinene og initieringen av hele applikasjonen.

## WebService kode

Koden som definerer kommunikasjon og Value Objects fra WebServices ligger i mappen `app/src/webservices/travelexpense/pdf`. All kode som ligger her er autogenerert av Flex 3 Builder via `Data - Import Web Services (WSDL)`.





## Lisens 
All kildekode og dokumentasjon er gjort tilgjengelig som åpen kildekode. Den kan fritt endres og gjenbrukes til egne behov (​[BSD lisens](README-LICENSE.txt)), men vi ønsker svært gjerne at du også engasjerer deg i vår videre utvikling av programmet slik at det kommer alle til gode.