//This code was created with the help of Cairngorm Creator by Tyler Beck.
//The portions of this document created by Cairngorm Creator 
//are provided on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
//CONDITIONS OF ANY KIND, either express or implied.
//========================================================



package no.makingwaves.cust.dss.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.net.SharedObject;
	
	import mx.rpc.IResponder;
	
	import no.makingwaves.cust.dss.business.*;
	import no.makingwaves.cust.dss.model.ErrorLocator;
	import no.makingwaves.cust.dss.model.ModelLocator;
	import no.makingwaves.cust.dss.vo.ErrorVO;
	import no.makingwaves.cust.dss.vo.TravelExpenseVO;

	public class LocalSaveCommand implements ICommand, IResponder
	{
		
		// functions ============================
		public function execute( event:CairngormEvent ) : void
		{
			var saveData:SharedObject = SharedObject.getLocal(ModelLocator.getInstance().localSaveName);
			trace("SharedObject is " + saveData.size + " bytes");
			saveData.data.valueList = new Array();
			// collect data
			var travelExpense:TravelExpenseVO = new TravelExpenseVO();
			travelExpense.personalinfo 			= ModelLocator.getInstance().activePerson;
			travelExpense.travel 				= ModelLocator.getInstance().activeTravel;
			travelExpense.accomodationList 		= ModelLocator.getInstance().travelAccomodationList;
			travelExpense.specificationList 	= ModelLocator.getInstance().travelSpecsList;
			travelExpense.travelAdvanceList 	= ModelLocator.getInstance().travelAdvanceList;
			travelExpense.travelCommentList 	= ModelLocator.getInstance().travelCommentList;
			travelExpense.travelDeductionList 	= ModelLocator.getInstance().travelDeductionList;
			travelExpense.travelOutlayList 		= ModelLocator.getInstance().travelOutlayList;
			
			saveData.data.travelExpense = travelExpense;
			try {
				saveData.flush();
			} catch (e:Error) {
				errorOccoured(e.message);
			}
		}
		
		//----------------------------------------------------------------------------
		public function result( e:Object ) : void {}
		
		//----------------------------------------------------------------------------
		public function fault( info : Object ) : void {
			errorOccoured();
		}
		
		private function errorOccoured(msg:String=""):void {
			var error:ErrorVO = new ErrorVO();
			error.error_code = ErrorLocator.getInstance().CRITICAL;
			error.error_message = "Saving data locally failed!"
			error.error_message += "\n\n" + msg;
			ErrorLocator.getInstance().errorCollector.addItem(error);
			ErrorLocator.getInstance().show();
		}

	}
}