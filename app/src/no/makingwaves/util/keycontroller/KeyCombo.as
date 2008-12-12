package no.makingwaves.util.keycontroller
{
	public class KeyCombo
	{
		private var _keyCode : Number;
		private var _ctrl : Boolean;
		private var _alt : Boolean;
		private var _shift : Boolean;
		
		public function KeyCombo(keyCode:Number, ctrl:Boolean, alt:Boolean, shift:Boolean)
		{
			_keyCode = keyCode;
			_ctrl = (ctrl == true) ? true : false;
			_alt = (alt == true) ? true : false;
			_shift = (shift == true) ? true : false;
		}
		
		public function get keyCode():Number {
			return _keyCode;
		}
		
		public function get ctrl():Boolean {
			return _ctrl;
		}
		
		public function get alt():Boolean {
			return _alt;
		}
		
		public function get shift():Boolean {
			return _shift;
		}

	}
}