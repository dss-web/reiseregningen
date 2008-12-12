package no.makingwaves.util.resources
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.CheckBox;
	import mx.controls.Label;
	import mx.core.UIComponent;
	import mx.resources.ResourceManager;
	
	import no.makingwaves.cust.dss.events.GetLocalesEvent;
	
	public class LocaleResourceController extends EventDispatcher
	{
		private var resourceList : ArrayCollection = new ArrayCollection();
		private var resourceBundleName : String = "resource_";
		private var _localeUrl : String;
		
		public function LocaleResourceController() {}
		
		/*
		* Add a new resource bundle
		*/
		public function addLocaleResource(localeId:String, localeUrl:String):void {
			resourceList.addItem({id: localeId, url: localeUrl});
		}
		
		/*
		* Set a new resource bundle active
		*/
		public function setActiveLocale(localeId:String):void {
			for (var i:Number = 0; i < resourceList.length; i++) {
				var currId:String = resourceList.getItemAt(i)["id"];
				if (currId == localeId) {
					// id found, check wether it is loaded into application
					var loaded:Boolean = false;
					var localesLoaded:Array = ResourceManager.getInstance().getLocales();
					for (var n:Number = 0; n < localesLoaded.length; n++) {
						if (localesLoaded[n] == localeId) {
							loaded = true;
							break;
						}
					}
					/*
					if (loaded) {
						// resource exists -> set to active
						ResourceManager.getInstance().localeChain = [localeId];
						ResourceManager.getInstance().update();
					} else {
					*/
						// resource not loaded -> load and set active
						loadLocaleResource(resourceList.getItemAt(i)["url"]);
					//}
					break;
				}
			}
		}
			
		public function getResource():String {
			return ResourceManager.getInstance().localeChain[0];
		}
		
		public function getResourceBundleName():String {
			return resourceBundleName + ResourceManager.getInstance().localeChain[0];
		}
		
		public function get bundleName():String {
			return resourceBundleName + ResourceManager.getInstance().localeChain[0];
		}
		
		/*
		* Load a new resource bundle xml file
		*/
		private function loadLocaleResource(url:String):void {
			_localeUrl = url;
			var event:CairngormEvent = new CairngormEvent( GetLocalesEvent.GET_LOCALES );
			CairngormEventDispatcher.getInstance().dispatchEvent( event );
		}
				
		public function get localeUrl():String {
			return _localeUrl;
		}

		public function getLabelText(e:Event):void {
			var comp : Label = Label(e.currentTarget);
			comp.text = ResourceManager.getInstance().getString(getResourceBundleName(), e.currentTarget.id);
		}
		
		public function getCheckboxLabel(e:Event):void {
			var comp : CheckBox = CheckBox(e.currentTarget);
			comp.label = ResourceManager.getInstance().getString(getResourceBundleName(), e.currentTarget.id+"_label");
		}
		
		public function getText(e:UIComponent):String {
			return ResourceManager.getInstance().getString(getResourceBundleName(), e.id);
		}
	}
}

/*
private var myResourcesNO:ResourceBundle = new ResourceBundle("no_NO", "mainBundle");
private var myResourcesUS:ResourceBundle = new ResourceBundle("en_US", "mainBundle");
			
myResourcesNO.content["open"] = "Åpne";
myResourcesNO.content["close"] = "Lukk";
myResourcesUS.content["open"] = "Open";
myResourcesUS.content["close"] = "Close";
resourceManager.addResourceBundle(myResourcesNO);
resourceManager.addResourceBundle(myResourcesUS);
resourceManager.update();
resourceManager.localeChain = ["no_NO"];
*/