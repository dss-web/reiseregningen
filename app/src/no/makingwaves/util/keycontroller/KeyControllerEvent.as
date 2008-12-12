package no.makingwaves.util.keycontroller
{
	import flash.events.Event;

	public class KeyControllerEvent extends Event
	{
		public static const KEYCOMBO_PRESSED:String = "keycombo_pressed";
		private var _keyCombo:KeyCombo;
		
		public function KeyControllerEvent( keyCombo:KeyCombo ) {
			super(KEYCOMBO_PRESSED);
			_keyCombo = keyCombo;
		}
		
		public function get keyCombo():KeyCombo {
			return _keyCombo;
		}
	}
}