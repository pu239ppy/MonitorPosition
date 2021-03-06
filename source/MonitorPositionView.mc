using Toybox.WatchUi;
using Toybox.Lang;
using Toybox.Sensor;

class MonitorPositionView extends WatchUi.View {

	var X = null;
	var Y = null;
	var Z = null;
	
	var Ax, Ay, Az, Mx, My, Mz = null;
	
	var pitch = null;
	var roll = null;
	hidden var accData;
  	var sensorInfo;
  	var myText;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

	function formatString(x, y, z, p, r) {
		var string = Lang.format(
			"X: $1$\nY: $2$\nZ: $3$\nP: $4$\nR: $5$",
			[x, y, z, p, r]);
			return string;
	}

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	myText = new WatchUi.TextArea({
        	:text=>"Loading",
        	:color=>Graphics.COLOR_WHITE,
        	:font=>Graphics.FONT_SMALL,
        	:locX =>WatchUi.LAYOUT_HALIGN_CENTER,
        	:locY=>WatchUi.LAYOUT_VALIGN_CENTER,
        	:width=>160,
            :height=>160
        });
    }


    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        myText.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    
	function accelData(sensorData) {
	    Ax = sensorData.accel[0];
 		Ay = sensorData.accel[1];
   		Az = sensorData.accel[2];
   		Toybox.System.println("Ax: " + Ax);
   		Toybox.System.println("Ay: " + Ay);
   		Toybox.System.println("Az: " + Az);
   	}
   		
	function magData(sensorData) {
		Mx = sensorData.mag[0];
 		My = sensorData.mag[1];
   		Mz = sensorData.mag[2];
   		Toybox.System.println("Mx: " + Mx);
   		Toybox.System.println("My: " + My);
   		Toybox.System.println("Mz: " + Mz);
	}

    function sensorCallBack(sensorData) {
    	System.println(sensorData.toString());
		System.println(sensorData instanceof Lang.Dictionary); 
		System.println(sensorData instanceof Lang.Array);
		System.println(sensorData instanceof Lang.Method);
		System.println(sensorData instanceof Lang.Symbol);
		System.println(sensorData has :accel and :accel != null);
		if (sensorData has :accel and sensorData.accel != null) {
			accelData(sensorData);
		}
		System.println(sensorData has :mag and :mag !=null);
		if (sensorData has :mag and sensorData.mag !=null) {
			magData(sensorData);
		}
	}
    
    function accelCallback(sensorData) {
    	X = sensorData.accelerometerData.x.slice(-1, null)[0];
 		Y = sensorData.accelerometerData.y.slice(-1, null)[0];
   		Z = sensorData.accelerometerData.z.slice(-1, null)[0];
   		pitch = sensorData.accelerometerData.pitch.slice(-1, null)[0];
   		roll = sensorData.accelerometerData.roll.slice(-1, null)[0];
   		Toybox.System.println("X: " + X);
   		Toybox.System.println("Y: " + Y);
   		Toybox.System.println("Z: " + Z);
   		Toybox.System.println("P: " + pitch);
   		Toybox.System.println("R: " + roll);
   		Toybox.System.println("Num samples: " + sensorData.accelerometerData.x.size());
   		
   		sensorInfo = new Sensor.Info();
        Toybox.System.println(sensorInfo.accel);
        Toybox.System.println(sensorInfo.mag);
   		
   		accData = formatString(X, Y, Z, pitch, roll);
   		Toybox.System.println(accData);
   		myText.setText(accData);
   		requestUpdate();
	}
}
