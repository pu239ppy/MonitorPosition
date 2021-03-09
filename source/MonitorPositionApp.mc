using Toybox.Application;
using Toybox.Sensor;

class MonitorPositionApp extends Application.AppBase {

	var sensorOptions = {
	    :period => 1,               // 1 second sample time
	    :accelerometer => {
	        :enabled => true,       // Enable the accelerometer
	        :sampleRate => 25,       // 25 samples
	        :includePitch => true,
	        :includeRoll => true
	    }
	};
 	var _aview = new AccelerometerPositionView();
 	var _mview = new MagnetometerPositionView();
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
    	Sensor.enableSensorEvents(_aview.method(:sensorCallBack));
        return [ _aview ];
    }
    
    function formatXYZ(mez, x, y, z) {
		var string = Lang.format(
			"$1$x: $2$ $1$y: $3$ $1$z: $4$",
			[mez, x, y, z]);
			return string;
	}
}