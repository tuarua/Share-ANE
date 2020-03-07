package {

import com.tuarua.Share;
import com.tuarua.fre.ANEError;

import flash.desktop.NativeApplication;
import flash.events.Event;
import flash.filesystem.File;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

import views.SimpleButton;

public class StarlingRoot extends Sprite {
    private var shareTextBtn:SimpleButton = new SimpleButton("Share Text");
    private var shareFileBtn:SimpleButton = new SimpleButton("Share File");

    private var share:Share;

    public function StarlingRoot() {
        super();
        TextField.registerCompositor(Fonts.getFont("fira-sans-semi-bold-13"), "Fira Sans Semi-Bold 13");
        NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);
    }

    public function start():void {
        initMenu();
        share = Share.shared();
    }

    private function initMenu():void {
        shareTextBtn.y = 100;
        shareFileBtn.y = 180;
        shareTextBtn.addEventListener(TouchEvent.TOUCH, onShareTextTouch);
        shareFileBtn.addEventListener(TouchEvent.TOUCH, onShareFileTouch);

        shareFileBtn.x = shareTextBtn.x = (stage.stageWidth - 200) / 2;

        addChild(shareTextBtn);
        addChild(shareFileBtn);

    }

    private function onShareTextTouch(event:TouchEvent):void {
        event.stopPropagation();
        var touch:Touch = event.getTouch(shareTextBtn, TouchPhase.ENDED);
        if (touch && touch.phase == TouchPhase.ENDED) {
            share.text("http://www.google.com");
        }
    }

    private static function getFileToShare():File {
        var sourceFile:File = File.applicationDirectory.resolvePath("dog.jpg");
        var destFile:File = File.applicationStorageDirectory.resolvePath("dog.jpg");
        if (sourceFile.nativePath.length == 0) { // Android - copy file to applicationStorageDirectory
            if (!destFile.exists) {
                sourceFile.copyTo(destFile, true);
            }
            return destFile;
        } else {
            return sourceFile;
        }
    }

    private function onShareFileTouch(event:TouchEvent):void {
        event.stopPropagation();
        var touch:Touch = event.getTouch(shareFileBtn, TouchPhase.ENDED);
        if (touch && touch.phase == TouchPhase.ENDED) {
            try {
                share.file(getFileToShare(), "Dog", "Nice Husky !!");
            } catch (e:ANEError) {
                trace(e.errorID);
                trace(e.getStackTrace());
                trace(e.source);
                trace(e.message);
            }
        }
    }

    private function onExiting(event:Event):void {
        Share.dispose();
    }

}
}
