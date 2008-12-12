package no.makingwaves.cust.dss.code
{
	import flash.events.EventDispatcher;
	
	import mx.core.Container;
	
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.util.keycontroller.KeyCombo;
	import no.makingwaves.util.keycontroller.KeyController;
	import no.makingwaves.util.keycontroller.KeyControllerEvent;

	public class KeyDistributer extends EventDispatcher
	{
		private var _keyController:KeyController;
		
		public function KeyDistributer()
		{
			_keyController = new KeyController(ModelLocator.getInstance().application);
			registerKeyCombos();
		}
		
		private function registerKeyCombos():void {
			// set keyboard shortcuts
			_keyController.setKeyWatch(49,true); 					// Ctrl + 1
			_keyController.setKeyWatch(50,true); 					// Ctrl + 2
			_keyController.setKeyWatch(51,true); 					// Ctrl + 3
			_keyController.setKeyWatch(52,true); 					// Ctrl + 4
			//_keyController.setKeyWatch(53,true); 					// Ctrl + 5
			_keyController.setKeyWatch(107); 	 					// + (for zoom in)
			_keyController.setKeyWatch(187); 	 					// + (for zoom in)
			_keyController.setKeyWatch(109); 	 					// - (for zoom out)
			_keyController.setKeyWatch(189); 	 					// - (for zoom out)
			//_keyController.setKeyWatch(187, false, false, true); 	// Shift + ? (for field help)
			//_keyController.setKeyWatch(83, false, false, true); 	// Shift + S (for language choice)
			//_keyController.setKeyWatch(72, false, false, true); 	// Shift + H (for help)
			//_keyController.setKeyWatch(76, false, false, true); 	// Shift + L (for sound on/off)
			//_keyController.setKeyWatch(84, false, false, true); 	// Shift + T (for checking if field is filled out)				
			
			_keyController.addEventListener(KeyControllerEvent.KEYCOMBO_PRESSED, keyComboPressed);
		}
		
		private function keyComboPressed(event:KeyControllerEvent):void {
			var model:ModelLocator = ModelLocator.getInstance();
			var pressedCombo:KeyCombo = event.keyCombo;
			
			if (pressedCombo.ctrl && !pressedCombo.shift && !pressedCombo.alt) {
				
				if (pressedCombo.keyCode == 49) {			// Ctrl + 1
					model.stateDistributer.openViewNum(0);	
					
				} else if (pressedCombo.keyCode == 50) {	// Ctrl + 2
					model.stateDistributer.openViewNum(1);	
					
				} else if (pressedCombo.keyCode == 51) {	// Ctrl + 3
					model.stateDistributer.openViewNum(2);
					
				} else if (pressedCombo.keyCode == 52) {	// Ctrl + 4
					model.stateDistributer.openViewNum(3);
					
				} else if (pressedCombo.keyCode == 53) {	// Ctrl + 4
					model.stateDistributer.openViewNum(4);
					
				}
				
			} else if (!pressedCombo.ctrl && pressedCombo.shift && !pressedCombo.alt) {
				if (pressedCombo.keyCode == 187) {			// Shift + ?
				
				} else if (pressedCombo.keyCode == 83) {	// Shift + S
					// set focus to language canvas
					
					
				} else if (pressedCombo.keyCode == 72) {	// Shift + H
					//model.sound.playSound('snd_intro_help');
				
				} else if (pressedCombo.keyCode == 76) {	// Shift + L
					
				
				} else if (pressedCombo.keyCode == 84) {	// Shift + T
				
				}
			} else {
				if (pressedCombo.keyCode == 107 || pressedCombo.keyCode == 187) {			// +
					// zoom in
					doZoom(model.application, "+");
					
				} else if (pressedCombo.keyCode == 109 || pressedCombo.keyCode == 189) {	// -
					// zoom out
					doZoom(model.application, "-");
				}
			}
		}
		
		public function doZoom(zoomContainer:Container, zoomDir:String="+"):void {
				var currentZoom:Number = zoomContainer.scaleX * 100;
				var newZoom:Number = currentZoom;
				if (zoomDir == "+" && currentZoom < 150) {
					newZoom = currentZoom + 10;
				} else if (zoomDir == "-" && currentZoom > 100) {
					newZoom = currentZoom - 10;
				}
				zoomContainer.scaleX = newZoom / 100;
				zoomContainer.scaleY = newZoom / 100;
			}
		
	}
}