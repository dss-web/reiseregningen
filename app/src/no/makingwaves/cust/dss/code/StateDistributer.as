package no.makingwaves.cust.dss.code
{
	import flash.events.EventDispatcher;
	
	import mx.core.Container;
	
	import no.makingwaves.cust.dss.model.ModelLocator;
	
	public class StateDistributer extends EventDispatcher
	{
		public const PERSONAL : String = "personal";
		public const TRAVEL : String = "travel";
		public const SPESIFICATIONS : String = "specifications";
		public const SETTLEMENTS : String = "settlements";
		
		private var stateContainer : Container;
		private var activeState : String = "";
		
		public function StateDistributer(container:Container) {
			stateContainer = container;		
		}
		
		public function openView(stateName:String, useTransitions:Boolean=true):void {
			if (useTransitions) {
				useTransitions = ModelLocator.getInstance().runTransitions;
			}
			if (activeState != "" && activeState != "base" && useTransitions) {
				try {
					stateContainer.setCurrentState(getAnimationState(stateName), useTransitions);
				} catch(e:Error) {
					stateContainer.setCurrentState(stateName, useTransitions);
				}
			} else {
				stateContainer.setCurrentState(stateName, useTransitions);
			}
			activeState = stateName;
		}
		
		private function getAnimationState(newStateName:String):String {
			return activeState + "_to_" + newStateName;
		}
		
		public function openNext():void {
			if (activeState == PERSONAL) {
				openView(TRAVEL);
				
			} else if (activeState == TRAVEL) {
				openView(SPESIFICATIONS);
				
			} else if (activeState == SPESIFICATIONS) {
				openView(SETTLEMENTS);
				
			}
		}
		
		public function externalFileLoaded():void {
			Reiseregningen(stateContainer).initForms();
		}
		
		public function getActiveState():String {
			return activeState;
		}
		
	}
}