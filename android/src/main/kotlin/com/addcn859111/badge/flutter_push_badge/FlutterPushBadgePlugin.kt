package com.addcn859111.badge.flutter_push_badge

import android.content.Context
import android.content.SharedPreferences
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.lang.ref.WeakReference

/** FlutterPushBadgePlugin */
public class FlutterPushBadgePlugin : FlutterPlugin, MethodCallHandler {

    private var contextRef: WeakReference<Context>? = null
    private var methodChannel: MethodChannel? = null

    internal constructor()

    internal constructor(context: Context?) {
        contextRef = WeakReference<Context>(context)
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        contextRef = WeakReference<Context>(flutterPluginBinding.applicationContext)
        methodChannel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "flutter_push_badge")
        methodChannel?.setMethodCallHandler(this)
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_push_badge")
            channel.setMethodCallHandler(FlutterPushBadgePlugin(registrar.context()))
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "setBadgeNumber") {
            val number = call.argument<String>("number")
            number?.let {
                ShortcutBadger.applyCount(contextRef?.get(), it.toInt())
                val sharePref = contextRef?.get()?.getSharedPreferences("BadgeNumber", Context.MODE_PRIVATE)
                sharePref?.edit()?.let { editor ->
                    editor.putString("BadgeNumber", it)
                    editor.commit()
                }
            }
        } else if (call.method == "getBadgeNumber") {
            val sharePref = contextRef?.get()?.getSharedPreferences("BadgeNumber", Context.MODE_PRIVATE)
            val number = sharePref?.getString("BadgeNumber", "0")
            result.success(number)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        contextRef?.clear()
        methodChannel?.setMethodCallHandler(null)
    }
}
