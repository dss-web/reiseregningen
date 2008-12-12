package no.makingwaves.util.keycontroller
{
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	public class KeyController extends EventDispatcher
	{
		private var _keyWatchList : ArrayCollection = new ArrayCollection();
		
		public function KeyController(reference:*)
		{
			reference.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			//addEventListener(KeyControllerEvent.KEYCOMBO_PRESSED, eventHandler);
		}
		
		public function setKeyWatch(keyCode:Number, ctrl:Boolean=false, alt:Boolean=false, shift:Boolean=false):void {
			var alreadyWatched:Boolean = false;
			var keyCombo:KeyCombo = new KeyCombo(keyCode, ctrl, alt, shift);
			for (var i:Number = 0; i < _keyWatchList.length; i++) {
				if (_keyWatchList[i] == keyCombo) {
					alreadyWatched = true;
					break;
				}
			}
			if (!alreadyWatched) {
				_keyWatchList.addItem(keyCombo);
			} else {
				trace("KeyWatch Warning: incl key '" + keyCode + "' is already watched.");
			}
		}
		
		private function keyUpHandler(event:KeyboardEvent):void {
			//event.keyCode
			var currentCombo:KeyCombo = new KeyCombo(event.keyCode, event.ctrlKey, event.altKey, event.shiftKey);
			for (var i:Number = 0; i < _keyWatchList.length; i++) {
				if (_keyWatchList[i].keyCode == currentCombo.keyCode &&
					_keyWatchList[i].ctrl == currentCombo.ctrl &&
					_keyWatchList[i].alt == currentCombo.alt &&
					_keyWatchList[i].shift == currentCombo.shift) {
						
						dispatchEvent(new KeyControllerEvent(currentCombo));
				}
			}
			
			//trace("Key combo pressed: " + ((event.ctrlKey)? "Ctrl " : "") + ((event.altKey)? " + Alt" : "") + ((event.shiftKey)? " + Shift" : "") + " + " + event.keyCode);
		}

	}
}