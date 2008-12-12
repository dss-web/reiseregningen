/**
  * Value object for language specifications imported into the application	
  */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	public class LanguageVO extends Object implements IValueObject
	{
		
		public var id : String = "";
		
		public var filename : String = "";
		
		public var name : String = "";
		
		public var desc : String = "";
				
	}
}