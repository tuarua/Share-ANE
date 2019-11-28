/*
 *  Copyright 2018 Tua Rua Ltd.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package com.tuarua.shareane

import android.content.Intent
import android.os.Environment
import com.adobe.fre.FREContext
import com.adobe.fre.FREObject
import com.tuarua.frekotlin.*
import java.io.File
import java.io.IOException
import android.support.v4.content.FileProvider

@Suppress("unused", "UNUSED_PARAMETER", "UNCHECKED_CAST")
class KotlinController : FreKotlinMainController {

    fun init(ctx: FREContext, argv: FREArgv): FREObject? {
        return true.toFREObject()
    }

    fun shareText(ctx: FREContext, argv: FREArgv): FREObject? {
        argv.takeIf { argv.size > 0 } ?: return FreArgException()
        val text = String(argv[0]) ?: return null
        val shareIntent = Intent()
        shareIntent.action = Intent.ACTION_SEND
        shareIntent.putExtra(Intent.EXTRA_TEXT, text)
        shareIntent.type = "text/plain"
        val chooserIntent = Intent.createChooser(shareIntent, null /* dialog title optional */)
        context?.activity?.startActivity(chooserIntent)
        return null
    }

    fun shareFile(ctx: FREContext, argv: FREArgv): FREObject? {
        argv.takeIf { argv.size > 3 } ?: return FreArgException()
        val path = String(argv[0]) ?: return FreArgException()
        if (path.isEmpty()) return FreException("Path is empty").getError()
        val mimeType = String(argv[1])
        val subject = String(argv[2])
        val text = String(argv[3])

        var file = File(path)
        clearExternalShareFolder()

        try {
            if (!fileIsOnExternal(file)) {
                file = copyToExternalShareFolder(file)
                        ?: return FreException("Can't copy to external share folder").getError()
            }

            val activity = context?.activity
            val appContext = activity?.applicationContext ?: return null

            val fileUri = FileProvider.getUriForFile(appContext, appContext.packageName + ".share_provider", file)
            val shareIntent = Intent()
            shareIntent.action = Intent.ACTION_SEND
            shareIntent.putExtra(Intent.EXTRA_STREAM, fileUri)
            if (subject != null) shareIntent.putExtra(Intent.EXTRA_SUBJECT, subject)
            if (text != null) shareIntent.putExtra(Intent.EXTRA_TEXT, text)
            shareIntent.type = mimeType ?: "*/*"
            shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            val chooserIntent = Intent.createChooser(shareIntent, null /* dialog title optional */)
            activity.startActivity(chooserIntent)
        } catch (e: IOException) {
            return FreException(e.message ?: "").getError()
        }
        return null
    }

    private fun clearExternalShareFolder() {
        val folder = getExternalShareFolder() ?: return
        if (folder.exists()) {
            for (file in folder.listFiles()) {
                file.delete()
            }
            folder.delete()
        }
    }

    private fun fileIsOnExternal(file: File): Boolean {
        return try {
            val filePath = file.canonicalPath
            val externalDir = Environment.getExternalStorageDirectory()
            externalDir != null && filePath.startsWith(externalDir.canonicalPath)
        } catch (e: IOException) {
            false
        }
    }

    @Throws(IOException::class)
    private fun copyToExternalShareFolder(file: File): File? {
        val folder = getExternalShareFolder() ?: return null
        if (!folder.exists()) {
            folder.mkdirs()
        }
        val newFile = File(folder, file.name)
        file.copyTo(newFile, true)
        return newFile
    }

    private fun getExternalShareFolder(): File? {
        val externalDir = context?.activity?.applicationContext?.externalCacheDir ?: return null
        return File(externalDir, "share")
    }

    override val TAG: String?
        get() = this::class.java.simpleName
    private var _context: FREContext? = null
    override var context: FREContext?
        get() = _context
        set(value) {
            _context = value
            FreKotlinLogger.context = _context
        }
}