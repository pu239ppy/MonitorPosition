using Toybox.WatchUi;
using Toybox.Sensor;

class AccelerometerView extends WatchUi.View {
	var Ax, Ay, Az = null;
	var pitch = null;
	var roll = null;
  	var acText;
	var visible = false;

    function initialize() {
        View.initialize();
        
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }
	
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	acText = new WatchUi.TextArea({
        	:text=>"Loading Accelerometer",
        	:color=>Graphics.COLOR_WHITE,
        	:font=>Graphics.FONT_SMALL,
        	:locX =>WatchUi.LAYOUT_HALIGN_CENTER,
        	:locY=>WatchUi.LAYOUT_VALIGN_CENTER,
        	:width=>160,
            :height=>160
        });
        visible = true;
    }


    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        acText.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	visible = false;
    }

	function pitchRoll(x, y) {
   		// Pithch atan2(y, sqrt(x^2 + z^2))
   		var pitch = Math.atan2(Ay, Math.sqrt(Math.pow(Ax, 2) + Math.pow(Ay, 2)));
		// roll  atan2(-x, z)
		var roll = Math.atan2(-(Ax), Ay);
		Toybox.System.println("P: " + pitch);
		Toybox.System.println("R: " + roll);
		return Lang.format("Pitch: $1$, Roll: $2$", [x,y]);
	}
		    
	function accelData(sensorData) {
	    Ax = sensorData.accel[0];
 		Ay = sensorData.accel[1];
   		Az = sensorData.accel[2];
   		Toybox.System.println("Ax: " + Ax);
   		Toybox.System.println("Ay: " + Ay);
   		Toybox.System.println("Az: " + Az);
   		return formatXYZ("A", Ax, Ay, Az);
   	}
   		
    function sensorCallBack(sensorData) {
    	var posString = "";
    	var pitchRollStr = "";
		if (visible and sensorData has :accel and sensorData.accel != null) {
			posString = accelData(sensorData);
			pitchRollStr = pitchRoll(sensorData.accel[0], sensorData.accel[1]);
			acText.setText(posString + "\n" + pitchRollStr);
   			requestUpdate();
		}
	}
}
