/**
 * Value object for travel specification details.
 */
package no.makingwaves.cust.dss.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
	[RemoteClass(alias="TravelSpecificationVO")]
	public class TravelSpecificationVO extends Object implements IValueObject
	{

		public static const TRANSPORT_OTHER : 		String = "Andre egne fremkomstmidler"; //Number = 0;
		public static const TRANSPORT_CAR : 		String = "Egen bil"; //Number = 1;
		public static const TRANSPORT_BOAT :		String = "Motorbåt"; //Number = 2;
		public static const TRANSPORT_MOTORCYCLE : 	String = "Motorsykkel"; //Number = 3;
		public static const TRANSPORT_BUS : 		String = "Buss/Bane/Trikk"; //Number = 4;
		public static const TRANSPORT_FERRIE : 		String = "Ferje"; //Number = 5;
		public static const TRANSPORT_AIRPLANE : 	String = "Fly"; //Number = 6;
		public static const TRANSPORT_TRAIN : 		String = "Tog"; //Number = 7;
		public static const TRANSPORT_TAXI : 		String = "Taxi"; //Number = 8;
		public static const TRANSPORT_RENTAL : 		String = "Leiebil"; //Number = 9;
		public static const TRANSPORT_PASSENGER : 	String = "Som passasjer"; //Number = 10;


		public var transportation_type : String = "";

		public var from_destination : String = "";

		public var from_date : Date;

		public var from_time : String = "";

		public var from_timezone : Number = -(new Date().timezoneOffset / 60);

		public var from_country : String = "";

		public var from_city : String = "";

		public var to_destination : String = "";

		public var to_date : Date;

		public var to_time : String = "";

		public var to_timezone : Number = -(new Date().timezoneOffset / 60);

		public var to_country : String = "";

		public var to_city : String = "";

		public var is_travel_start : Boolean = false;

		public var is_travel_continious : Boolean = false;

		public var is_travel_end : Boolean = false;

		public var intermediate_landing : Boolean = false;

		public var specification : *;

		public var cost : CostVO = new CostVO();

	}
}

