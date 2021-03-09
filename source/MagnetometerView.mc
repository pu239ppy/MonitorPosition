using Toybox.WatchUi;
using Toybox.Lang;
using Toybox.Sensor;

class MagnetometerView extends WatchUi.View {

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
    	var pitchRollStr = "";
		if (sensorData has :mag and sensorData.mag !=null) {
			magString = magData(sensorData);
			myText.setText(magString);
   			requestUpdate();
		}
	}
}
