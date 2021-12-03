package com.example.test_native_android;

import android.content.Intent;

import androidx.annotation.NonNull;

import com.example.test_native_android.demoapp.activity.StartUpActivity;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.startActivity/testChannel";

    @Override
    public void configureFlutterEngine(@NonNull @org.jetbrains.annotations.NotNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler((call, result) -> {
            if (call.method.equals("StartSecondActivity")) {
                Intent intent = new Intent(MainActivity.this, StartUpActivity.class);
                startActivity(intent);
                result.success("ActivityStarted");
            } else {
                result.notImplemented();
            }
        });

    }
}


