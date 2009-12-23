package no.makingwaves.cust.dss.code
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

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
		private var stateTimer : Timer = new Timer(2100, 1);

		public var stateChangeInProgress : Boolean = false;


		public function StateDistributer(container:Container) {
			stateContainer = container;		

		}

		public function openView(stateName:String, useTransitions:Boolean=true):void {
			trace("OPEN VIEW: " + stateName + ": READY: " + !stateChangeInProgress);
			if (!stateChangeInProgress || stateName.indexOf("_to_") != -1) {

				if (useTransitions) {
					useTransitions = ModelLocator.getInstance().runTransitions;
					if (useTransitions && stateName != "base") {
						stateChangeInProgress = true;
						stateTimer.reset();
						stateTimer.addEventListener(TimerEvent.TIMER_COMPLETE, stateChangeRelease);
						stateTimer.start();
					}
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
		}

		private function stateChangeRelease(e:TimerEvent):void {
			stateTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, stateChangeRelease);
			stateChangeInProgress = false;
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

