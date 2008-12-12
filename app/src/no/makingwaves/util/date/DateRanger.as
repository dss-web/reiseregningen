package no.makingwaves.util.date
{
	public class DateRanger
	{
		public var total_24hours : Number = 0;
		
		public var total_hours : Number = 0;
		
		public var total_min : Number = 0;
		
		public var days : Number = 0;
		
		public var hours : Number = 0;
		
		public var minutes : Number = 0;
		
		public var seconds : Number = 0;
		
		public var overnight : Boolean = false; 
		
		public function DateRanger()
		{
		}
		
		public function getDateRange(startDate:Date, endDate:Date):void {
			if (startDate && endDate) {
				var ms_per_day:uint = 1000 * 60 * 60 * 24;
				var sec_per_day:uint = 1000 * 60 * 60;
				var min_per_day:uint = 1000 * 60;
				var calcObject:Object = new Object();
				calcObject.rangeStart = startDate;
				calcObject.rangeEnd = endDate;
				var dateRange:Date = new Date(calcObject.rangeEnd - calcObject.rangeStart);
				
				this.total_24hours = Math.floor(dateRange.time / ms_per_day);		
				this.total_hours = Math.floor(dateRange.time / sec_per_day);
				this.total_min = Math.floor(dateRange.time / min_per_day);
				
				this.days = Math.floor(dateRange.time / 24 / 60 / 60000);
				this.hours = Math.floor(total_hours - (this.days * 24));	
				this.minutes = Math.floor((dateRange.time - (this.total_hours * 60 * 60000)) / 60000);			
				this.seconds = Math.floor((dateRange.time - (this.total_hours * 60 * 60000) - (this.total_min * 60000)) / 1000);			
				
				this.overnight = ((this.total_24hours > 0) || (endDate.getDay() > startDate.getDay()));
			}
		}

	}
}