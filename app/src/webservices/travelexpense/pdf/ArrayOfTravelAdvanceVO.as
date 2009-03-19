/**
 * ArrayOfTravelAdvanceVO.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package webservices.travelexpense.pdf
{
	import mx.utils.ObjectProxy;
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.ICollectionView;
	import mx.rpc.soap.types.*;
	/**
	 * Typed array collection
	 */

	public class ArrayOfTravelAdvanceVO extends ArrayCollection
	{
		/**
		 * Constructor - initializes the array collection based on a source array
		 */
        
		public function ArrayOfTravelAdvanceVO(source:Array = null)
		{
			super(source);
		}
        
        
		public function addTravelAdvanceVOAt(item:TravelAdvanceVO,index:int):void 
		{
			addItemAt(item,index);
		}

		public function addTravelAdvanceVO(item:TravelAdvanceVO):void 
		{
			addItem(item);
		} 

		public function getTravelAdvanceVOAt(index:int):TravelAdvanceVO 
		{
			return getItemAt(index) as TravelAdvanceVO;
		}

		public function getTravelAdvanceVOIndex(item:TravelAdvanceVO):int 
		{
			return getItemIndex(item);
		}

		public function setTravelAdvanceVOAt(item:TravelAdvanceVO,index:int):void 
		{
			setItemAt(item,index);
		}

		public function asIList():IList 
		{
			return this as IList;
		}
        
		public function asICollectionView():ICollectionView 
		{
			return this as ICollectionView;
		}
	}
}
