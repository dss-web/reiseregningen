/**
  * Value object for personal information.	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="PersonalInfoVO")]
	public class PersonalInfoVO extends Object implements IValueObject
	{

		public var socialsecuritynumber:String = "";

		public var firstname:String = "";
		
		public var lastname:String = "";

		public var adress:String = "";

		public var zip:String = "";

		public var postoffice:String = "";

		public var jobtitle:String = "";
		
		public var account:String = "";
		
		public var workplace:String = "";
		
		public var department:String = "";
		
		public var domicialname:String = "";
		
		public var domicialnum:String = "";
		
		public var valid:Boolean;

	}
}