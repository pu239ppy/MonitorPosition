using Toybox.WatchUi;
using Toybox.System;
using Toybox.FitContributor;
  
class PositionBehaviorDelegate extends WatchUi.BehaviorDelegate {
	function initialize() {
		WatchUi.BehaviorDelegate.initialize();
  	}
  	
  	function onNextPage() {
  		System.println("next page");
  		System.println("Current View: " + $.currentView);
  		$.currentView = ($.currentView + 1) % $.views.size();
  		System.println("New Current View: " + $.currentView);
  		WatchUi.switchToView($.views[$.currentView], new PositionBehaviorDelegate(), WatchUi.SLIDE_UP);   
  		Sensor.enableSensorEvents($.views[$.currentView].method(:sensorCallBack));
 		return true;
  	}
  	
  	 function onPreviousPage() {
  	 	System.println("previous page");
  	 	System.println("Current View: " + $.currentView);
  	 	$.currentView = ($.currentView - 1) % $.views.size();
  	 	System.println("New Current View: " + $.currentView);
  	 	WatchUi.switchToView($.views[$.currentView], new PositionBehaviorDelegate(), WatchUi.SLIDE_DOWN);
  	 	Sensor.enableSensorEvents($.views[$.currentView].method(:sensorCallBack));
 		return true;
  	}
  	
	function onSelect() {
		if (Toybox has :ActivityRecording) {
	    	if (($.session == null) || ($.session.isRecording() == false)) {
     	 		System.println("Creating session");
				$.session = ActivityRecording.createSession({
	                 :name=>"Monitor Position",
	                 :sport=>ActivityRecording.SPORT_GENERIC,
	                 :subSport=>ActivityRecording.SUB_SPORT_GENERIC
	           	});
	           	System.println("Session is " + $.session);
	           	$.fields[:aX] = $.session.createField("aX", 0, FitContributor.DATA_TYPE_FLOAT, {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"g"});
			   	$.fields[:aY] = $.session.createField("aY", 1, FitContributor.DATA_TYPE_FLOAT, {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"g"});
			   	$.fields[:aZ] = $.session.createField("aZ", 2, FitContributor.DATA_TYPE_FLOAT, {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"g"});
			   	$.fields[:mX] = $.session.createField("mX", 3, FitContributor.DATA_TYPE_FLOAT, {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"m"});
			   	$.fields[:mY] = $.session.createField("mY", 4, FitContributor.DATA_TYPE_FLOAT, {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"m"});
			   	$.fields[:mZ] = $.session.createField("mZ", 5, FitContributor.DATA_TYPE_FLOAT, {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"m"});
	           	$.session.start();
			}
	       	else if (($.session != null) && $.session.isRecording()) {
	       		System.println("Stopping session");
				$.session.stop();
	            $.session.save();
	            $.session = null;
	        }
	    }
	    return true;
	}
}