using Toybox.Application;
using Toybox.Sensor;

class MonitorPositionApp extends Application.AppBase {
 	var views = [new AccelerometerView(), new MagnetometerView()];
	var currentView = 0;
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
    	//Sensor.registerSensorDataListener(_view.method(:accelCallback), sensorOptions);
    	Sensor.enableSensorEvents(sensorCallBack(:sensorCallBack));
        return [ views[currentView], new PositionBehaviorDelegate() ];
    }
    
    function sensorCallBack(sensorData) {
		views[currentView].sensorCallBack(sensorData);
   	}
    
    function formatXYZ(mez, x, y, z) {
		var string = Lang.format(
			"$1$x: $2$ $1$y: $3$ $1$z: $4$",
			[mez, x, y, z]);
			return string;
	}
}