/**
  * Value object for a complete travel expense form	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	[RemoteClass(alias="TravelExpenseVO")]
	public class TravelExpenseVO extends Object implements IValueObject
	{
		
		public var personalinfo : PersonalInfoVO;
		
		public var travel : TravelVO;
		
		public var specificationList : ArrayCollection = new ArrayCollection();
		
		public var accomodationList : ArrayCollection = new ArrayCollection();
		
		public var travelAdvanceList : ArrayCollection = new ArrayCollection();
		
		public var travelOutlayList : ArrayCollection = new ArrayCollection();
		
		public var travelDeductionList : ArrayCollection = new ArrayCollection();
		
		public var travelCommentList : ArrayCollection = new ArrayCollection();

	}
}