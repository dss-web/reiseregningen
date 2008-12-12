/**
 * ArrayOfTravelDeductionVO.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package webservices.travelexpense.pdf{
    import mx.utils.ObjectProxy;
    import mx.collections.ArrayCollection;
    import mx.collections.IList;
    import mx.collections.ICollectionView;
    import mx.rpc.soap.types.*;
    /**
     * Typed array collection
     */

    public class ArrayOfTravelDeductionVO extends ArrayCollection
    {
        /**
         * Constructor - initializes the array collection based on a source array
         */
        
        public function ArrayOfTravelDeductionVO(source:Array = null)
        {
            super(source);
        }
        
        
        public function addTravelDeductionVOAt(item:TravelDeductionVO,index:int):void {
            addItemAt(item,index);
        }
            
        public function addTravelDeductionVO(item:TravelDeductionVO):void {
            addItem(item);
        } 

        public function getTravelDeductionVOAt(index:int):TravelDeductionVO {
            return getItemAt(index) as TravelDeductionVO;
        }
                
        public function getTravelDeductionVOIndex(item:TravelDeductionVO):int {
            return getItemIndex(item);
        }
                            
        public function setTravelDeductionVOAt(item:TravelDeductionVO,index:int):void {
            setItemAt(item,index);
        }

        public function asIList():IList {
            return this as IList;
        }
        
        public function asICollectionView():ICollectionView {
            return this as ICollectionView;
        }
    }
}
