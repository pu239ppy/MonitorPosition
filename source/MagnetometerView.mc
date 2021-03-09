using Toybox.WatchUi;
using Toybox.Sensor;

class MagnetometerView extends WatchUi.View {
	var Mx, My, Mz = null;
  	var magText;
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
    	magText = new WatchUi.TextArea({
        	:text=>"Loading Magnetometer",
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
        magText.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	visible = false;
    }
  		
	function magData(sensorData) {
		Mx = sensorData.mag[0];
 		My = sensorData.mag[1];
   		Mz = sensorData.mag[2];
   		Toybox.System.println("Mx: " + Mx);
   		Toybox.System.println("My: " + My);
   		Toybox.System.println("Mz: " + Mz);
   		return $.formatXYZ("M", Mx, My, Mz);
	}

    function sensorCallBack(sensorData) {
    	var magString = "";
		if (visible and sensorData has :mag and sensorData.mag !=null) {
			magString = magData(sensorData);
			magText.setText(magString);
   			requestUpdate();
		}
	}
}