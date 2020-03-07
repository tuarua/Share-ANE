package com.tuarua {
import flash.events.StatusEvent;
import flash.external.ExtensionContext;

/** @private */
public class ShareANEContext {
    internal static const NAME:String = "ShareANE";
    internal static const TRACE:String = "TRACE";
    private static var _context:ExtensionContext;

    public function ShareANEContext() {
    }

    public static function get context():ExtensionContext {
        if (_context == null) {
            try {
                _context = ExtensionContext.createExtensionContext("com.tuarua." + NAME, null);
                _context.addEventListener(StatusEvent.STATUS, gotEvent);
            } catch (e:Error) {
                trace("[" + NAME + "] ANE not loaded properly.  Future calls will fail.");
            }
        }
        return _context;
    }

    private static function gotEvent(event:StatusEvent):void {
        switch (event.level) {
            case TRACE:
                trace("[" + NAME + "]", event.code);
                break;
        }
    }

    public static function dispose():void {
        if (_context == null) return;
        trace("[" + NAME + "] Unloading ANE...");
        _context.removeEventListener(StatusEvent.STATUS, gotEvent);
        _context.dispose();
        _context = null;
    }

}
}
