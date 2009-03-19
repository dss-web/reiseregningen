/**
 * ArrayOfTravelSpecificationVO.as
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

	public class ArrayOfTravelSpecificationVO extends ArrayCollection
	{
		/**
		 * Constructor - initializes the array collection based on a source array
		 */
        
		public function ArrayOfTravelSpecificationVO(source:Array = null)
		{
			super(source);
		}
        
        
		public function addTravelSpecificationVOAt(item:TravelSpecificationVO,index:int):void 
		{
			addItemAt(item,index);
		}

		public function addTravelSpecificationVO(item:TravelSpecificationVO):void 
		{
			addItem(item);
		} 

		public function getTravelSpecificationVOAt(index:int):TravelSpecificationVO 
		{
			return getItemAt(index) as TravelSpecificationVO;
		}

		public function getTravelSpecificationVOIndex(item:TravelSpecificationVO):int 
		{
			return getItemIndex(item);
		}

		public function setTravelSpecificationVOAt(item:TravelSpecificationVO,index:int):void 
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
