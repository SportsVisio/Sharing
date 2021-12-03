package com.example.sports_visio;

import android.content.Intent;

import androidx.annotation.NonNull;

import com.example.sports_visio.demoapp.activity.StartUpActivity;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "sports/stream";

    @Override
    public void configureFlutterEngine(@NonNull @org.jetbrains.annotations.NotNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler((call, result) -> {
            if (call.method.equals("sendToken")) {
                Intent intent = new Intent(MainActivity.this, StartUpActivity.class);
                startActivity(intent);
                result.success("ActivityStarted");
            } else {
                result.notImplemented();
            }
        });

    }
}


