/**
 * ArrayOfRateVO.as
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

	public class ArrayOfRateVO extends ArrayCollection
	{
		/**
		 * Constructor - initializes the array collection based on a source array
		 */
        
		public function ArrayOfRateVO(source:Array = null)
		{
			super(source);
		}
        
        
		public function addRateVOAt(item:RateVO,index:int):void 
		{
			addItemAt(item,index);
		}

		public function addRateVO(item:RateVO):void 
		{
			addItem(item);
		} 

		public function getRateVOAt(index:int):RateVO 
		{
			return getItemAt(index) as RateVO;
		}

		public function getRateVOIndex(item:RateVO):int 
		{
			return getItemIndex(item);
		}

		public function setRateVOAt(item:RateVO,index:int):void 
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
