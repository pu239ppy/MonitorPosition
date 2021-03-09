using Toybox.Application;
using Toybox.Sensor;
using Toybox.Lang;

var currentView = 0;
var views = [new AccelerometerView(), new MagnetometerView()];

function formatXYZ(mez, x, y, z) {
	var string = Lang.format(
		"$1$x: $2$ $1$y: $3$ $1$z: $4$",
		[mez, x, y, z]);
		return string;
}

class MonitorPositionApp extends Application.AppBase {


	var sensorIterator;
	//var sensorInfo;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
		Sensor.enableSensorEvents(views[currentView].method(:sensorCallBack));
        return [ views[currentView], new PositionBehaviorDelegate() ];
    }
    
    function sensorCallBack(sensorData) {
		views[0].sensorCallBack(sensorData);
   	}
    
}