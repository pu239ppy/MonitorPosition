using Toybox.WatchUi;
using Toybox.Sensor as Sensor;

class AltitudeView extends WatchUi.View {
	var visible = false;
	var altText;

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
    	altText = new WatchUi.TextArea({
        	:text=>"Loading Altitude",
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
        altText.draw(dc);
    }
    
    
    // Does nothing here, but is required when switching pages
    function sensorCallBack(sensorData) {
    	Toybox.System.println("Altitude: " + sensorData.altitude);
    	altText.setText(Lang.format("Altitude: $1$", [sensorData.altitude]));
    	requestUpdate();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	visible = false;
    }

}