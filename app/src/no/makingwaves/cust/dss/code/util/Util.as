package no.makingwaves.cust.dss.code.util {
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	import no.makingwaves.cust.dss.model.ModelLocator;
	
	
	public class Util {
		
		public function Util() {}
		
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
		
		public static function checkForLinks(string:String=""):String {
			var timeout:Number = 80;
			if (string != null) {
				while (string.indexOf('%') != -1 || timeout != 0) {
					timeout--;
					if (string.indexOf('%') != string.lastIndexOf('%')) {
						try {
							var startInd:Number = string.indexOf('%');
							var endInd:Number = string.substring(startInd+1, string.length).indexOf('%') + startInd;
							var linkRef:String = string.substring(startInd+1, endInd+1);
							var linkString:String = ResourceManager.getInstance().getString(ModelLocator.getInstance().resources.bundleName, 'link_' + linkRef);
							if (linkString != null && linkString != "") {
								var realLink:String = linkString.substr(linkString.lastIndexOf(' ')+1, linkString.length);
								var htmlCode:String = "<a href='" + realLink + "' target='sph'><u>" + linkString.substr(0, linkString.lastIndexOf(' ')) + "</u></a>";
								string = string.replace("%"+linkRef+"%", htmlCode);
							}
							
						} catch (e:Error) { trace(e.message); }
					}
				}
			}
			return string;
		}
		
		public static function getResourceUrl(id:String):String {
			var resourceList:ArrayCollection = ModelLocator.getInstance().resourceList;
			for (var i:Number = 0; i < resourceList.length; i++) {
				if (resourceList.getItemAt(i).id == id) {
					return resourceList.getItemAt(i).url;
				}
			}
			return "";
		}
	}
}