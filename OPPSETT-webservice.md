# Oppsett av utviklingsplattform - .NET WebServices

For å handtere utskrift av PDF filer direkte fra FLEX applikasjon benyttes en Web Service som er skrevet i .NET 2.0 og C#. Denne benytter XML data direkte fra FLEX applikasjonen, og skriver informasjonen direkte inn i en ferdig PDF mal. 

## Nødvendige ressurser

 * Visual Studio 2008. Kode skrevet i C#.
 * IIS 6.0
 * iTextSharp.dll versjon 4.0.3.0 (Benyttes for å skrive til PDF fil)
   * Download: http://www.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/i/it/itextsharp/
 * log4net.dll, nyeste version (Benyttes for logging)
   * Download: http://logging.apache.org/log4net/download.html

Når de nødvendige ressursene er lastet ned kan Web Service prosjektet startes. `itextsharp.dll` og `log4net.dll` legges til som referanser.

## Installasjonsveiledning .NET WebService

For å sette opp Web Service prosjekt åpnes `TravelExpWS.sln` fra Visual Studio 2008. Solution filen referer til 3 ulike prosjekter. `itextsharp.dll` og `log4net.dll` legges til som referanser til samtlige prosjekter.
 * `MakingWaves.Common.WS`
 * `Makingwaves.TravelExp.Impl`
 * `TravelExpWS`

**TravelExpWS** er en web site og krever att denne settes opp i den lokale IIS instansen. De andre 2 prosjektene er klasse prosjekt. For denne solution filen er prosjektet konfigurert mot en virtual directory som heter TravelExpWS og er plassert direkte under default installasjonen på IIS som er `http://localhost`. Denne kan endres ved eget behov. Virtuelt directory `http://localhost/TravelExpWS` er satt opp til å peke til TravelExpWS folderen. WebService `TravelExpense.asmx` i samme mappe er den Web Service som lagrer XML data i PDF fil.

**TravelExpWS** innholder en fil `default.aspx` som kan benyttes for å generere en test PDF uten å benytte FLEX applikasjonen.
Kode referer til noen statiske plasser på filsystemet som må endres til å passe utvikling og produksjons miljø. Følgende verdier må konfigureres før det kan kjøres optimalt - fra `Web.config`:

```xml
<appSettings>
    <add key="MakingWaves.TravelExp.Impl.TravelExpense.Processing.PdfTemplateFileName" 
         value="C:\Making Waves\TravelWS\ws\TravelExpWS\App_Data\TravelExpenseTemplate.pdf"/>
    <add key="MakingWaves.Common.WS.Utils.DebugEx.DestFolder" 
         value="C:\Making Waves\TravelWS\ws\Dest"/>
</appSettings>
```

 * `MakingWaves.TravelExp.Impl.TravelExpense.Processing.PdfTemplateFileName` -- Denne definerer hvor template for PDF finnes.
 * `MakingWaves.Common.WS.Utils.DebugEx.DestFolder` -- Denne benyttes for å lagre debug informasjon.

### Kode endring

For å teste må det endres en hardkodet referanse til test data (samme type av data som Flex Applikasjon bygger opp). En test fil med XML data finnes som `TravelExpWS\App_Data\TravelData.xml`. Hardkodet referanse til XML data finnes i klassen `TravelExpense` og metoden `GetTravelObjectFromXml_Test()` som finnes under TravelExpWS\App_Code.

### Kjøre prosjektet

 * Gå til `http://localhost/TravelExpWS/default.aspx` for å generere en test PDF.
 * Gå til `http://localhost/TravelExpWS/TravelExpense.asmx` for url til web service som skal benyttes fra FLEX applikasjon.

