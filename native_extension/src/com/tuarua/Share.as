/* Copyright 2018 Tua Rua Ltd.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */


package com.tuarua {
import com.tuarua.fre.ANEError;

import flash.filesystem.File;

public class Share {
    private static var _shared:Share;

    public function Share() {
        if (_shared) {
            throw new Error(ShareANEContext.NAME + " is a singleton, use .shared()");
        }
        if (ShareANEContext.context) {
            var ret:* = ShareANEContext.context.call("init");
            if (ret is ANEError) throw ret as ANEError;
        }
        _shared = this;
    }

    public static function shared():Share {
        if (_shared == null) {
            new Share();
        }
        return _shared;
    }

    public function text(text:String):void {
        ShareANEContext.context.call("shareText", text);
    }

    public function file(file:File, subject:String = null, text:String = null):void {
        var ret:* = ShareANEContext.context.call("shareFile",
                file.nativePath,
                getMimeType(file.extension),
                subject, text);
        if (ret is ANEError) throw ret as ANEError;
    }

    private function getMimeType(extension:String):String {
        switch (extension) {
            case "jpeg":
            case "jpg":
                return "image/jpeg";
            case "gif":
                return "image/gif";
            case "png":
                return "image/png";
            case "svg":
                return "image/svg+xml";
            case "tif":
            case "tiff":
                return "image/tiff";
                // audio
            case "aac":
                return "audio/aac";
            case "oga":
                return "audio/ogg";
                // video
            case "avi":
                return "video/x-msvideo";
            case "mpeg":
                return "video/mpeg";
            case "ogv":
                return "video/ogg";
                // other
            case "csv":
                return "text/csv";
            case "htm":
            case "html":
                return "text/html";
            case "json":
                return "application/json";
            case "pdf":
                return "application/pdf";
            case "txt":
                return "text/plain";
        }
        return null;
    }

    public static function dispose():void {
        if (ShareANEContext.context) {
            ShareANEContext.dispose();
        }
    }
}
}
