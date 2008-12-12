package no.makingwaves.util {
	
	public class Util {
		
		public function Util() {
		}
		
		public static function searchAndReplace(inString:String, searchString:String, replaceString:String):String {
			while (inString.indexOf(searchString) != -1) {
				var endIndex:Number = inString.indexOf(searchString) + searchString.length;
				inString = inString.substring(0, inString.indexOf(searchString)) + replaceString +  inString.substr(endIndex, inString.length);
							
			}
			return inString;
		}
		
		// extracts a string from the inString var, where string starts after startId and ends before endId
		public static function extractString(inString:String, startId:String, endId:String):String {
			return inString.substring(inString.indexOf(startId) + startId.length, inString.substring(inString.indexOf(startId) + startId.length,inString.length).indexOf(endId) + ((inString.indexOf(startId) + startId.length)));
		}
		
		public static function formatDate(date:Date, dateFormat:String="DD.MM.YY"):String {
			if (date == null) { return ""; }
			var dd:String = date.getDate().toString();
			var mm:String = (date.getMonth() + 1).toString();
			var yy:String = date.getFullYear().toString().substr(2,2);
			
			dd = (dd.length == 1) ? "0"+dd : dd;
			mm = (mm.length == 1) ? "0"+mm : mm;
			
			var dateFormat:String = dateFormat;
			var formattedDate:String = Util.searchAndReplace(dateFormat, "DD", dd);
			formattedDate = Util.searchAndReplace(formattedDate, "MM", mm);
			formattedDate = Util.searchAndReplace(formattedDate, "YY", yy);
			
			return formattedDate;
		}
	}
}