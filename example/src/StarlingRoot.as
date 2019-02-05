package {

import com.tuarua.ShareANE;
import com.tuarua.fre.ANEError;

import flash.desktop.NativeApplication;
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

import views.SimpleButton;

public class StarlingRoot extends Sprite {
    private var shareTextBtn:SimpleButton = new SimpleButton("Share Text");
    private var shareFileBtn:SimpleButton = new SimpleButton("Share File");

    private var share:ShareANE;

    public function StarlingRoot() {
        super();
        TextField.registerCompositor(Fonts.getFont("fira-sans-semi-bold-13"), "Fira Sans Semi-Bold 13");
        NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);
    }

    public function start():void {
        initMenu();
        share = ShareANE.share;
    }

    private function initMenu():void {
        shareTextBtn.y = 100;
        shareFileBtn.y = 180;
        shareTextBtn.addEventListener(TouchEvent.TOUCH, onIndexTouch);
        shareFileBtn.addEventListener(TouchEvent.TOUCH, onDeleteTouch);

        shareFileBtn.x = shareTextBtn.x = (stage.stageWidth - 200) / 2;

        addChild(shareTextBtn);
        addChild(shareFileBtn);

    }

    private function onIndexTouch(event:TouchEvent):void {
        event.stopPropagation();
        var touch:Touch = event.getTouch(shareTextBtn, TouchPhase.ENDED);
        if (touch && touch.phase == TouchPhase.ENDED) {
            share.text("http://www.google.com")
        }
    }

    private static function getFileToShare():File {
        var ret:File = File.applicationStorageDirectory.resolvePath("dog.jpg");
        if (!ret.exists) {
            var inFile:File = File.applicationDirectory.resolvePath("dog.jpg");
            var inStream:FileStream = new FileStream();
            inStream.open(inFile, FileMode.READ);
            var fileContents1:String = inStream.readUTFBytes(inStream.bytesAvailable);
            inStream.close();

            var outFile:File = File.applicationStorageDirectory.resolvePath("dog.jpg");
            var outStream:FileStream = new FileStream();
            outStream.open(outFile, FileMode.WRITE);
            outStream.writeUTFBytes(fileContents1);
            outStream.close();
            return outFile;
        }
        return ret;
    }

    private function onDeleteTouch(event:TouchEvent):void {
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
        ShareANE.dispose();
    }

}
}
