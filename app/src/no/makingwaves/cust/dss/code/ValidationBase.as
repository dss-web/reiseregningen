package no.makingwaves.cust.dss.code
{
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;
	import mx.controls.DateField;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.events.ValidationResultEvent;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	import mx.validators.DateValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	import no.makingwaves.cust.dss.code.util.Util;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.view.components.validationDisplayer;
	
	public class ValidationBase extends VBox
	{
		// attributes ============================
		[Bindable]
		protected var model : ModelLocator = ModelLocator.getInstance();
		
		// validator values
		public const DEFAULT : String = "Validator";
		public const STRING : String = "StringValidator";
		public const DATE : String = "DateValidator";
		public const VALIDATOR_FORMAT_TIME : String = "time";
		public const VALIDATOR_FORMAT_DOUBLE : String = "double";
		
		public var validationSourceList : ArrayCollection = new ArrayCollection();
		public var validationCustomSourceList : ArrayCollection = new ArrayCollection();
		private var winValidationList : ArrayCollection = new ArrayCollection(); // of validationDisplayer;
		
		public var isValidating : Boolean = false;
		
		public function dateField_init(dateField:DateField):void {
			dateField.formatString = ResourceManager.getInstance().getString(model.resources.getResourceBundleName(), 'DATE_FORMAT');
            dateField.dayNames = ResourceManager.getInstance().getString(model.resources.getResourceBundleName(), 'DAYS_NAMES').split(",");
            dateField.monthNames = ResourceManager.getInstance().getString(model.resources.getResourceBundleName(), 'MONTH_NAMES').split(",");
            dateField.monthSymbol = "";
            dateField.yearSymbol = "";
            dateField.firstDayOfWeek = 1;
            dateField.showToday = true;
            dateField.maxYear = new Date().getFullYear();
            //dateField.selectableRange = {rangeStart: new Date(2007,0,1), rangeEnd: new Date()};
        }
			
		public function setAssistance(id:String, type:String):void {
			var fullAssistance:String = ResourceManager.getInstance().getString(model.resources.bundleName, id);
			fullAssistance = Util.checkForLinks(fullAssistance);
			if (type == model.PERSONAL) {
				model.helpTextPersonalinfo = (fullAssistance != null) ? fullAssistance : "";
			} else if (type == model.TRAVEL) {
				model.helpTextTravel = (fullAssistance != null) ? fullAssistance : "";
			} else if (type == model.SPESIFICATIONS) {
				model.helpTextTravel = (fullAssistance != null) ? fullAssistance : "";
			} else if (type == model.SETTLEMENT) {
				model.helpTextSettlement = (fullAssistance != null) ? fullAssistance : "";
			}
		}
		
		
		// VALIDATION CODE =================================================================
		
		public function addValidationField(source:*, type:String="StringValidator", required:Boolean=true, minLength:Number=NaN, maxLength:Number=NaN):void {
			switch(type) {
				case "StringValidator":
					var stringValidator:StringValidator = new StringValidator();
					stringValidator.source = source;
					stringValidator.property = "text";
					stringValidator.required = required;
					stringValidator.minLength = minLength;
					stringValidator.maxLength = maxLength;
					stringValidator.addEventListener(ValidationResultEvent.INVALID, this.displayValidation);
					stringValidator.addEventListener(ValidationResultEvent.VALID, this.undisplayValidation);
					//validationSourceList.addItem(stringValidator);
					enableValidator(stringValidator);
					break;
				case "DateValidator":
					var datevalidator:DateValidator = new DateValidator();
					datevalidator.source = source;
					datevalidator.property = "text";
					datevalidator.required = required;
					datevalidator.allowedFormatChars = "./";
					datevalidator.inputFormat = ResourceManager.getInstance().getString(model.resources.getResourceBundleName(), 'DATE_FORMAT');
					datevalidator.validateAsString = true;
					datevalidator.addEventListener(ValidationResultEvent.INVALID, displayValidation);
					datevalidator.addEventListener(ValidationResultEvent.VALID, undisplayValidation);
					//validationSourceList.addItem(datevalidator);
					enableValidator(datevalidator);
					break;
				default:	
					var validator:Validator = new Validator();
					validator.source = source;
					validator.property = "selectedValue";
					validator.required = required;
					validator.addEventListener(ValidationResultEvent.INVALID, displayValidation);
					validator.addEventListener(ValidationResultEvent.VALID, undisplayValidation);
					//validationSourceList.addItem(validator);
					enableValidator(validator);
					break;
			}
		}
		
		private function enableValidator(validator:*):void {
			var found:Boolean = false;
			for (var i:Number = 0; i < validationSourceList.length; i++) {
				if (validationSourceList.getItemAt(i) == validator) {
					found = true;
					validator.enabled = true;
					validationSourceList.setItemAt(validator, i);
					break;
				}
			}
			if (!found) {
				validationSourceList.addItem(validator);
			}
		}
		
		public function validateAll():Boolean {
			return (this.validateDetailsForm() && this.validateCustomFields()); 
		}
					
		public function validateDetailsForm():Boolean {
			undisplayAllValidators();
			for (var i:Number = 0; i < validationSourceList.length; i++) {
				if (validationSourceList.getItemAt(i).enabled && validationSourceList.getItemAt(i).source != null) {
					var vResult:ValidationResultEvent;
	            	vResult = validationSourceList.getItemAt(i).validate();
	            	if (vResult.type==ValidationResultEvent.INVALID) {
	            		return false; 
	            	}
	   			}
			}
			return true;
		}
		
		public function removeValidation(component:*):void {
			// remove it from custom validation
			var i:Number;
			for (i = 0; i < validationCustomSourceList.length; i++) {
				if (validationCustomSourceList.getItemAt(i).component == component) {
					validationCustomSourceList.removeItemAt(i);
					i--;
				}
			}
			// remove from normal validation
			for (i = 0; i < validationSourceList.length; i++) {
				if (validationSourceList.getItemAt(i).source == component) {
					validationSourceList.getItemAt(i).enabled = false;
				}
			}
		}
		
		// CUSTOM VALIDATION CODE ===========================================================
		
		public function validateCustomField(component:UIComponent):Boolean {
			var result:Boolean;
			for (var i:Number = 0; i < validationCustomSourceList.length; i++) {
				if (validationCustomSourceList.getItemAt(i).component == component) {
					if (validationCustomSourceList.getItemAt(i).type == "date") {
						return validateCustomDate(validationCustomSourceList.getItemAt(i));
					} else if (validationCustomSourceList.getItemAt(i).type == "string") {
						return validateCustomString(validationCustomSourceList.getItemAt(i));
					}
				}
			}
			return true;
		}
		
		public function validateCustomFields():Boolean {
			var result:Boolean;
			for (var i:Number = 0; i < validationCustomSourceList.length; i++) {
				switch(validationCustomSourceList.getItemAt(i).type) {
					case "date":
						result = validateCustomDate(validationCustomSourceList.getItemAt(i));
						if (!result) { return false; }
						break;
					case "string":
						result = validateCustomString(validationCustomSourceList.getItemAt(i));
						if (!result) { return false; }
						break;
					case "time":
						result = validateCustomTime(validationCustomSourceList.getItemAt(i));
						if (!result) { return false; }
						break;
						
				}
			}
			return true;
		} 
		
		private function validateCustomDate(dateObject:Object, validateHours:Boolean=false):Boolean {
			var minDate:Date = (dateObject.minRelatedField == null) ? dateObject.minDate : dateObject.minRelatedField.selectedDate;
			var maxDate:Date = (dateObject.maxRelatedField == null) ? dateObject.maxDate : dateObject.maxRelatedField.selectedDate;
			
			if (!validateHours) {
				if (minDate != null)
					minDate.setHours(12,00,00,00);
					
				if (maxDate != null)
					maxDate.setHours(12,00,00,00);
			}
			
			var focusComponent:UIComponent = dateObject.component as UIComponent;
			if (dateObject.txtcomponent != null) { focusComponent = dateObject.txtcomponent; }
			var compareDate:Date = DateField(dateObject.component).selectedDate;
			compareDate.setHours(12,00,00,00);
			if (minDate != null) {
				if (compareDate < minDate) {
					// date invalid, lower than minimum value
					var customErrorMsg : String = ResourceManager.getInstance().getString(model.resources.bundleName, "error_date_toolow");
					customErrorMsg = customErrorMsg.replace("%1", Util.formatDate(minDate, ResourceManager.getInstance().getString(model.resources.getResourceBundleName(), 'DATE_FORMAT')));
					showValidationError(focusComponent, customErrorMsg);
					return false;
				}
			} 
			if (maxDate != null) {
				if (compareDate > maxDate) {
					// date invalid, larger than maximum value
					var customErrorMsg : String = ResourceManager.getInstance().getString(model.resources.bundleName, "error_date_toohigh");
					customErrorMsg = customErrorMsg.replace("%1", Util.formatDate(maxDate, ResourceManager.getInstance().getString(model.resources.getResourceBundleName(), 'DATE_FORMAT')));
					showValidationError(focusComponent, customErrorMsg);
					return false;
				}
			}
			return true;
		} 
		
		private function validateCustomString(stringObject:Object):Boolean {
			try {
				var value:String = TextInput(stringObject.component).text;
				var errorMsg:String = "";
				if (Boolean(stringObject.charsOnly)) {
					// check for only chars - charcodes between 32-47, 58-126
					for (var i:Number = 0; i < value.length; i++) {
						if (!isNaN(Number(value.charAt(i))) && value.charAt(i) != " ") {
							var componentId:String = UIComponent(stringObject.component).id + "_label";
							var compLabel:String = ResourceManager.getInstance().getString(model.resources.bundleName, componentId);
							var defaultMsgStart:String = ResourceManager.getInstance().getString(model.resources.bundleName, "error_field_description_default");
							errorMsg = ResourceManager.getInstance().getString(model.resources.bundleName, "error_strings");
							if (compLabel) {
								errorMsg = errorMsg.replace("%1", compLabel);
							} else {
								errorMsg = errorMsg.replace("%1", defaultMsgStart);
							}
							showValidationError(stringObject.component, errorMsg);
							return false;
						}
					}
					
				} else if (Boolean(stringObject.numsOnly) || stringObject.format == this.VALIDATOR_FORMAT_TIME) {
					if (stringObject.format == this.VALIDATOR_FORMAT_TIME) {
						// format as time/clock value - collect format and actual values
					    var nonValidChars:Boolean = false;
					    var nonValidCharList:Array = [".", ",", ":", "-", "/", "\\", ";"];
					    for (var l:int = 0; l < nonValidCharList.length; l++) {
					        if (value.indexOf(nonValidCharList[l]) != -1) {
						    	nonValidChars = true;
						    	break;
					        }
					    }
					    var maxHH:Number = Number(String(stringObject.numMaxFormat.toString()).substr(0,2));
						var maxMM:Number = Number(String(stringObject.numMaxFormat.toString()).substr(2,2));
						var realHH:Number = Number(value.substr(0,2));
						var realMM:Number = Number(value.substr(2,2));
						// test values against eachother
						if (realHH > maxHH || realMM > maxMM || nonValidChars) {
							// not valid - show error message
							var timeFormat:String = ResourceManager.getInstance().getString(model.resources.bundleName, "TIME_FORMAT");
							errorMsg = ResourceManager.getInstance().getString(model.resources.bundleName, "error_time_format");
							errorMsg = errorMsg.replace("%1", timeFormat);
							showValidationError(stringObject.component, errorMsg);
							return false;
						}
						
					} else {
						// check for only numbers - charcodes between 48 and 57
						var doubleAllowed:Boolean = false;
						if (stringObject.format == this.VALIDATOR_FORMAT_DOUBLE) {
							doubleAllowed = true;
							value = value.replace(",", ".");
							TextInput(stringObject.component).text = value;
						}
						
						if (isNaN(Number(value))) {
							var componentId:String = UIComponent(stringObject.component).id + "_label";
							var compLabel:String = ResourceManager.getInstance().getString(model.resources.bundleName, componentId);
							var defaultMsgStart:String = ResourceManager.getInstance().getString(model.resources.bundleName, "error_field_description_default");
							errorMsg = ResourceManager.getInstance().getString(model.resources.bundleName, "error_numbers");
							
							if (compLabel) {
								errorMsg = errorMsg.replace("%1", compLabel);
							} else {
								errorMsg = errorMsg.replace("%1", defaultMsgStart);
							}
							showValidationError(stringObject.component, errorMsg);
							return false;
						}
					}
					
				// test date format if there is a date value inserted
				} else if (stringObject.format == this.DATE && value != "") {
					var valid:Boolean = true;
					if (value.indexOf(".") == -1) {
						if (value.length == 6) {
							value = value.substr(0,2) + "." + value.substr(2,2) + "." + value.substr(4,2);
							stringObject.component.text = value;
						} else if (value.length == 8) {
							value = value.substr(0,2) + "." + value.substr(2,2) + "." + value.substr(6,2);
							stringObject.component.text = value;
						}
					}
					var dateValues:Array = value.split(".");
					if (dateValues.length != 3) {
						valid = false;
					} else {
						for (var i:Number = 0; i < dateValues.length; i++) {
							if (isNaN(Number(dateValues[i])) || dateValues[i].length != 2) {
								valid = false;
								break;
							}
						}
					}
					if (!valid) {
						errorMsg = ResourceManager.getInstance().getString(model.resources.bundleName, "error_date_format");
						var format:String = ResourceManager.getInstance().getString(model.resources.bundleName, "DATE_FORMAT");
						errorMsg = errorMsg.replace("%1", format);
						showValidationError(stringObject.component, errorMsg);
						return false;
					}
				}
			} catch (e:Error) { trace("validateCustomString: " + e.message);}
			return true;
		}
		
		private function validateCustomTime(timeObject:Object):Boolean {
			var errorMsg:String = "";
			if (Util.formatDate(DateField(timeObject.fromDate).selectedDate) == Util.formatDate(DateField(timeObject.toDate).selectedDate)) {
				var fromHH:Number = Number(TextInput(timeObject.fromTime).text.substr(0,2));
				var fromMM:Number = Number(TextInput(timeObject.fromTime).text.substr(2,2));
				var toHH:Number = Number(TextInput(timeObject.toTime).text.substr(0,2));
				var toMM:Number = Number(TextInput(timeObject.toTime).text.substr(2,2));
				if (toHH < fromHH || (toHH == fromHH && toMM < fromMM)) {
					// arrivalTime is before destinastion starttime - not valid
					errorMsg = ResourceManager.getInstance().getString(model.resources.bundleName, "error_time_toolow");
					errorMsg = errorMsg.replace("%1", TextInput(timeObject.fromTime).text);
					showValidationError(timeObject.toTime, errorMsg);
					return false;
				}
			}
			return true;
		}
		
		public function addCustomDateValidation(component:DateField, minDate:Date=null, maxDate:Date=null, minRelatedField:DateField=null, maxRelatedField:DateField=null, textReplacer:TextInput=null):void {
			var dateObject:Object = new Object();
			dateObject.type = "date";
			dateObject.component = component;
			dateObject.txtcomponent = textReplacer;
			dateObject.minDate = minDate;
			dateObject.maxDate = maxDate;
			dateObject.minRelatedField = minRelatedField;
			dateObject.maxRelatedField = maxRelatedField;
			validationCustomSourceList.addItem(dateObject);
		}
		
		public function addCustomStringValidation(component:TextInput, charsOnly:Boolean=true, numsOnly:Boolean=false, format:String="", numMaxFormat:Number=0):void {
			var stringObject:Object = new Object();
			stringObject.type = "string";
			stringObject.component = component;
			stringObject.charsOnly = charsOnly;
			stringObject.numsOnly = numsOnly;
			stringObject.format = format;
			stringObject.numMaxFormat = numMaxFormat;
			validationCustomSourceList.addItem(stringObject);
		}
		
		public function addCustomTimeValidation(component:TextInput, fromDate:DateField, fromTime:TextInput, toDate:DateField, toTime:TextInput):void {
			var timeObject:Object = new Object();
			timeObject.type = "time";
			timeObject.component = component;
			timeObject.fromDate = fromDate;
			timeObject.fromTime = fromTime;
			timeObject.toDate = toDate;
			timeObject.toTime = toTime;
			validationCustomSourceList.addItem(timeObject);
		}
		
		public function removeCustomTimeValidation(component:TextInput):void {
			for (var i:Number = 0; i < validationCustomSourceList.length; i++) {
				if (validationCustomSourceList.getItemAt(i).type == "time") {
					if (validationCustomSourceList.getItemAt(i).component == component) {
						validationCustomSourceList.removeItemAt(i);
						break;
					}
				}
			}
		}
		
		// VALIDATION DISPLAY METHODS =======================================================
		
		/*
		*  Validation event triggered
		*  Shows validation error message except if user tabbed backwards or new focus component
		*  has some connection with prev component
		*/
		public function displayValidation(e:ValidationResultEvent):void {
			try {
				var component:UIComponent = UIComponent(e.currentTarget.source);
				var currentFocus:UIComponent = focusManager.getFocus() as UIComponent;
				var nextFocus:UIComponent = focusManager.getNextFocusManagerComponent() as UIComponent;
				if (nextFocus != component) {
					if (component.id.substr(0, currentFocus.id.length) != currentFocus.id) {
						showValidationError(component);
					}
				}
			} catch (e:Error) {
				trace(e.message);
			}
		}
		
		public function showValidationError(component:UIComponent, customErrorMsg:String=""):void {
			if (!isValidating && getValidationWindow(component) == null) {
				// set validating on to avoid other components to validate at the same time
				isValidating = true;
				// open validation window
				var validationObj : Object = new Object();				
		        var winValidation : validationDisplayer = validationDisplayer(PopUpManager.createPopUp(component.parent, validationDisplayer, false));
		        if (customErrorMsg == "") {
		        	winValidation.validationText = ResourceManager.getInstance().getString(model.resources.bundleName, component.id+"_validator");
		        } else {
		        	winValidation.validationText = customErrorMsg;
		        }
		        winValidation.nextFocusComponent = component;
		        winValidation.callFromContainer = this;
		        
		        // close any other validation windows
		        undisplayAllValidators();
		        
		        // register validation object in list
		        validationObj.component = component;
		        validationObj.window = winValidation;
		        winValidationList.addItem(validationObj);
		        trace("showValidationError("+component+", "+customErrorMsg+")");
		        
		        // set window position
		        var pt:Point = new Point(component.x, component.y);
            	pt = component.parent.localToGlobal(pt);
            	
		        winValidation.x = pt.x + component.width + 10;
		        winValidation.y = pt.y + (component.height/2) - (winValidation.height/2);

			}
		}
		
		public function undisplayValidation(e:ValidationResultEvent):void {
			var component:UIComponent = UIComponent(e.currentTarget.source);
			for (var i:Number = 0; i < winValidationList.length; i++) {
				if (component == winValidationList.getItemAt(i).component) {
					winValidationList.getItemAt(i).window.hide();
					winValidationList.removeItemAt(i);
					break;
				}
			}
			//validateCustomField(component);
   		}
   		
   		public function undisplayAllValidators():void {
   			for (var i:Number = 0; i < winValidationList.length; i++) {
   				winValidationList.getItemAt(i).window.close(); //hide();
			}
			winValidationList.removeAll();
   		}		
   		
   		public function getValidationWindow(component:UIComponent):validationDisplayer {
   			for (var i:Number = 0; i < winValidationList.length; i++) {
				if (component == winValidationList.getItemAt(i).component) {
					return validationDisplayer(winValidationList.getItemAt(i).window);
				}
			}
			return null;
   		}
   		
   		public function disableValidation():void {
   			this.undisplayAllValidators();
   			
   			validationCustomSourceList.removeAll();
   			for (var i:Number = 0; i < this.validationSourceList.length; i++) {
   				this.validationSourceList.getItemAt(i).enabled = false;
   				this.validationSourceList.getItemAt(i).removeEventListener(ValidationResultEvent.INVALID, this.displayValidation);
   				this.validationSourceList.getItemAt(i).removeEventListener(ValidationResultEvent.VALID, this.undisplayAllValidators);
   			}
   			this.validationSourceList.removeAll();
   		}
			
		public function continueClicked():void {
			if (this.validateDetailsForm()) {
				if (this.validateCustomFields()) {
					model.stateDistributer.openNext();
				}
			}
		}
			
		public function getFormattedDate(date:Date):String {
			var dateFormat:String = resourceManager.getString(model.resources.bundleName, "DATE_FORMAT");
			return Util.formatDate(date, dateFormat);
		}
	}
}