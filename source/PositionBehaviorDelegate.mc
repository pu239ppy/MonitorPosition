using Toybox.WatchUi;
using Toybox.System;
  
class PositionBehaviorDelegate extends WatchUi.BehaviorDelegate {
	function initialize() {
		WatchUi.BehaviorDelegate.initialize();
		
  	}
  	
  	function onNextPage() {
  		System.println("next page");
  		$.currentView = ($.currentView + 1) % $.views.size();
  		WatchUi.switchToView($.views[$.currentView], new PositionBehaviorDelegate(), WatchUi.SLIDE_UP);   
  		Sensor.enableSensorEvents($.views[$.currentView].method(:sensorCallBack));
 		return true;
  	}
  	
  	 function onPreviousPage() {
  	 	System.println("previous page");
  	 	$.currentView = ($.currentView + 1) % $.views.size();
  	 	WatchUi.switchToView($.views[$.currentView], new PositionBehaviorDelegate(), WatchUi.SLIDE_DOWN);
  	 	Sensor.enableSensorEvents($.views[$.currentView].method(:sensorCallBack));
 		return true;
  	}
}