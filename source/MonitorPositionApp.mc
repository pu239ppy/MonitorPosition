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
 	var _view = new MonitorPositionView();
	var sensorIterator;
	//var sensorInfo;

    function initialize() {
        AppBase.initialize();
        /*sensorIterator = sensor.getRegisteredSensors(null);
        while (	true ) {
        	sensorInfo = sensorIterator.next();
        	if ( sensorInfo has :name ) {
        		Toybox.System.println(sensorInfo.name);
        	} else {
        	    break;
        	}
        }*/
        /*sensorInfo = new Sensor.Info();
        Toybox.System.println(sensorInfo.accel);
        Toybox.System.println(sensorInfo.mag);*/
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
    	Sensor.enableSensorEvents(_view.method(:sensorCallBack));
        return [ _view ];
    }
}