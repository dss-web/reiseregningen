package no.makingwaves.cust.dss.code
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	//import no.makingwaves.cust.dss.view.accessibility.instanthelper;
	
	public class AccessibilityDistributer extends EventDispatcher
	{
		private var _applicationRef : Container;
		
		public function AccessibilityDistributer(container:Container) {
			_applicationRef = container;
		}
		
		public function addAccessibility(comp:UIComponent, text:String="", forceSimple:Boolean=false, noAutoLabeling:Boolean=true):void {
			comp.accessibilityProperties = new AccessibilityProperties();
            comp.accessibilityProperties.name = text;
            comp.accessibilityProperties.forceSimple = forceSimple; 
            comp.accessibilityProperties.noAutoLabeling = noAutoLabeling;	
            
			flash.accessibility.Accessibility.updateProperties();
		}
		
		/* function obsolite
		public function showAccessibilityHelp(component:UIComponent, help:String):void {
			// open validation window 
			var validationObj : Object = new Object();				
		    var winValidation : instanthelper = instanthelper(PopUpManager.createPopUp(_applicationRef, instanthelper, false));
		    winValidation.validationText = help;

		    winValidation.nextFocusComponent = component;
		}
		*/
		
	}
}