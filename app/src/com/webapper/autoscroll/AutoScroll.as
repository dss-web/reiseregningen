package com.webapper.autoscroll
{
	// AutoScroll 1.0
	// Written in January 2008 by Daryl Banttari of Webapper Services, LLC
	// Released to the public domain.  Use in any way for whatever purpose you desire, but at your own risk!
	// Updates may be found at http://www.darylb.net/flexautoscroll/
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.Container;
	
	public class AutoScroll
	{
		public static var isMouseScrolling : Boolean = false;
		
		public static function autoScroll(event : Event) : void {
			var container : Container = Container(event.currentTarget);
			//trace( "----------\r" + new Date().toTimeString());
	
			var focusItem : DisplayObject = DisplayObject(container.focusManager.getFocus());
	
			// if no scrollbar or focused item, nothing to do
			if(container.verticalScrollBar && focusItem) {
				//trace( "focus item: " + focusItem.toString() );
				
				// is the current focus item inside our container?
				if( focusItem == container || !container.contains(focusItem) ) {
					//trace( "focus item not a child of watched container.");
					return;
				}
				
				if (AutoScroll.isMouseScrolling)
					return;
					
				// find the focusItem's y coord in the scrolled container 
				//  by summing the y offsets of the item and all parent containers in the tree
				//  between the target and the scrolled container
				var focusTopEdge : int = focusItem.y;
				var thisItem : DisplayObjectContainer = focusItem.parent;
				while(thisItem != container) {
					focusTopEdge += thisItem.y;
					thisItem = thisItem.parent;
				}
				var focusBottomEdge : int = focusTopEdge + focusItem.height;
				
				//trace( focusItem.toString() );
				//trace( " focusTopEdge: " + focusTopEdge);
				//trace( ", focusBottomEdge=" + focusBottomEdge );
				//trace( ", height: " + focusItem.height );
				
				//trace( " scrollbar:" + container.verticalScrollBar.scrollPosition + "/" + container.verticalScrollPosition + "/" + container.verticalScrollBar.maxScrollPosition );
				var scrollbarRange : int = container.verticalScrollBar.maxScrollPosition;
				
				var visibleWindowHeight : int = container.height;
				//trace( " visibleWindowHeight:" + visibleWindowHeight );
		
				var lastVisibleY : int = visibleWindowHeight + container.verticalScrollPosition;
				if(container.horizontalScrollBar) {
					// remove the horiz scrollbar height from lastVisibleY
					lastVisibleY -= container.horizontalScrollBar.height;
				}
				//trace( ", lastVisibleY=" + lastVisibleY );
				//trace( ", focusBottomEdge-lastVisibleY=" + (focusBottomEdge-lastVisibleY) );
				//trace( ", focusTopEdge=" + focusTopEdge );
				
				if( focusTopEdge == container.verticalScrollPosition ) {
					//trace( "Bar not moved, already at top edge of focus item." );
				}
				else if( focusTopEdge < container.verticalScrollPosition ) {
					container.verticalScrollPosition = focusTopEdge;
					//trace( "Moved bar up to " + focusTopEdge );
				}
				else if( focusBottomEdge-lastVisibleY > 0 ) {
					var newPos : int = Math.min(scrollbarRange, container.verticalScrollPosition + (focusBottomEdge-lastVisibleY));
					container.verticalScrollPosition = newPos;
					//trace( "Moved bar down to " + newPos );
				}
				else {
					//trace( "Bar not moved." );;
				}
			}
		}
		
		public static function mouseScroller(event : MouseEvent) : void {
			trace(event.currentTarget);
		}
	}
}