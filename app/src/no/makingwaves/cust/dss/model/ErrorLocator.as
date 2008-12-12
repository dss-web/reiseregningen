//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.model
{

	import com.adobe.cairngorm.model.ModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.resources.ResourceManager;
	
	import no.makingwaves.cust.dss.vo.*;

	[Bindable]
	public class ErrorLocator implements com.adobe.cairngorm.model.ModelLocator
	{
		private static var errorLocator : no.makingwaves.cust.dss.model.ErrorLocator;

		//-----------------------------------------------------------
		public static function getInstance():no.makingwaves.cust.dss.model.ErrorLocator
		{
			if ( errorLocator == null )
				errorLocator = new no.makingwaves.cust.dss.model.ErrorLocator();

			return errorLocator;
		}

		//-----------------------------------------------------------
		public function ErrorLocator():void
		{
			if ( no.makingwaves.cust.dss.model.ErrorLocator.errorLocator != null )
				throw new Error( 'Only one ErrorLocator instance should be instantiated' );
		}
		
		// ERROR STATES  ==========================================================
		
		public const NO_ERROR : Number = 0;
		
		public const CRITICAL : Number = 1;
		
		public const WARNING : Number = 2;
		
		public const LOW_RISK : Number = 3;
		
		public var errorCollector : ArrayCollection = new ArrayCollection();
		
		public var errorState : Number = 0;
		
		public function show():void {
			try {
				
				var error:ErrorVO = ErrorVO(errorCollector.getItemAt(0));
				if (error.error_code != this.NO_ERROR) {
					
					Alert.okLabel = ResourceManager.getInstance().getString(no.makingwaves.cust.dss.model.ModelLocator.getInstance().resources.bundleName, "button_ok")
					Alert.show(error.error_message, getErrorHeader(error.error_code), Alert.OK, null, this.errorCleanUp);					
				}
					
			} catch (e:Error){
				// ignore error in error
			}
		}
		
		private function getErrorHeader(error_code:Number):String {
			var header:String = "";
			switch (error_code) {
				case CRITICAL:
					header = ResourceManager.getInstance().getString(no.makingwaves.cust.dss.model.ModelLocator.getInstance().resources.bundleName, "error_critical");
					break;
				case WARNING:
					header = ResourceManager.getInstance().getString(no.makingwaves.cust.dss.model.ModelLocator.getInstance().resources.bundleName, "error_warning");
					break;
				case LOW_RISK:
					header = ResourceManager.getInstance().getString(no.makingwaves.cust.dss.model.ModelLocator.getInstance().resources.bundleName, "error_info");
					break;
			}
			return header;
		}
		
		private function errorCleanUp(e:CloseEvent):void {
			this.errorCollector.removeItemAt(0);
		}
		
	}
}