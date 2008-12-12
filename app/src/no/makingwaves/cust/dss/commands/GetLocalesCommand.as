//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;

	public class GetLocalesCommand implements ICommand, IResponder
	{
		// attributes ============================
		private var _localesDelegate:LocalesDelegate = new LocalesDelegate(this as IResponder);


		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			var delegate:LocalesDelegate = new LocalesDelegate( this );
			delegate.getLocales();			
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void
		{
			try {
				var id:String = e.result.type[0].toString();
				var newResource:ResourceBundle = new ResourceBundle(id, "resource_" + id);
				
				// collect resource media data
				var resourceText:XMLList = e.result.media.texts;
				var resourceSound:XMLList = e.result.media.sounds;
				var resourceVideo:XMLList = e.result.media.videos;
				var resourceImages:XMLList = e.result.media.images;
				
				// add resource data to resource bundle
				for each (var text:XML in resourceText.text) {
					newResource.content[text.@id] = text.@value;
				}
				for each (var sound:XML in resourceSound.sound) {
					//newResource.content[sound.@id] = "Embed(" + sound.@value + ")";
					newResource.content[sound.@id] = sound.@value;
				}
				for each (var video:XML in resourceVideo.video) {
					newResource.content[video.@id] = video.@value;
				}
				for each (var image:XML in resourceImages.image) {
					newResource.content[image.@id] = image.@value;
				}
				// collect formatting data
				var formattingList:XMLList = e.result.formatting;
				for each (var format:XML in formattingList.format) {
					newResource.content[format.@type] = format.@value;
				}				
				// add resource to resourcemanager
				ResourceManager.getInstance().addResourceBundle(newResource);					
				ResourceManager.getInstance().localeChain = [id];
				ResourceManager.getInstance().update();
				
			} catch(e:Error) {
				errorOccoured(e.errorID + ": " + e.message);
				
			} finally {
				ModelLocator.getInstance().initializer.stepComplete();
								
			}	
		}
		
		//----------------------------------------------------------------------------
		public function fault( info : Object ) : void
		{
			errorOccoured();
		}
		
		private function errorOccoured(msg:String=""):void {
			var error:ErrorVO = new ErrorVO();
			error.error_code = ErrorLocator.getInstance().CRITICAL;
			error.error_message = "Loading language resources failed!"
			error.error_message += "\nThe application will not be functional.";
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			//ErrorLocator.getInstance().show();
			// step completed anyhow
			ModelLocator.getInstance().initializer.stepComplete();
		}

	}
}