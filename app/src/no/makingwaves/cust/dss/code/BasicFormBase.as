package no.makingwaves.cust.dss.code
{
	import mx.containers.VBox;
	import mx.controls.DateField;
	
	import no.makingwaves.cust.dss.code.ValidationBase;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.TravelSpecificationVO;
	
	public class BasicFormBase extends ValidationBase
	{
		// attributes ============================

		private var _continueTravel : Boolean = true;

		public function autoFillIn(editMode:Boolean=false):void {
			
		}
		
		public function submitData(specifications:*):* {
			return specifications;
		}
		
		public function clearFields():void {
			this.disableValidation();
		}
        
        public function get continueTravel():Boolean {
        	return _continueTravel;
        }
        
        public function set continueTravel(state:Boolean):void {
        	_continueTravel = state;
        }
	}
}