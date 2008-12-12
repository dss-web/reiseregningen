/**
 * ArrayOfTravelOutlayVO.as
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

    public class ArrayOfTravelOutlayVO extends ArrayCollection
    {
        /**
         * Constructor - initializes the array collection based on a source array
         */
        
        public function ArrayOfTravelOutlayVO(source:Array = null)
        {
            super(source);
        }
        
        
        public function addTravelOutlayVOAt(item:TravelOutlayVO,index:int):void {
            addItemAt(item,index);
        }
            
        public function addTravelOutlayVO(item:TravelOutlayVO):void {
            addItem(item);
        } 

        public function getTravelOutlayVOAt(index:int):TravelOutlayVO {
            return getItemAt(index) as TravelOutlayVO;
        }
                
        public function getTravelOutlayVOIndex(item:TravelOutlayVO):int {
            return getItemIndex(item);
        }
                            
        public function setTravelOutlayVOAt(item:TravelOutlayVO,index:int):void {
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
