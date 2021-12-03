package com.example.sports_visio;

import android.content.Intent;

import androidx.annotation.NonNull;

import com.example.sports_visio.demoapp.KinesisVideoWebRtcDemoApp;
import com.example.sports_visio.demoapp.activity.SimpleNavActivity;
import com.example.sports_visio.demoapp.activity.SimpleNavActivityPlacement;
import com.example.sports_visio.demoapp.activity.StartUpActivity;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "sports/stream";
    public  static  FlutterEngine flutterEngine1;

    @Override
    public void configureFlutterEngine(@NonNull @org.jetbrains.annotations.NotNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler((call, result) -> {
           flutterEngine1=flutterEngine;
            if (call.method.equals("sendToken")) {
                KinesisVideoWebRtcDemoApp.result = result;
                KinesisVideoWebRtcDemoApp.username = call.argument("username");
                KinesisVideoWebRtcDemoApp.password = call.argument("password");
                KinesisVideoWebRtcDemoApp.streamId = call.argument("streamId");
                KinesisVideoWebRtcDemoApp.gameId = call.argument("gameId");
                KinesisVideoWebRtcDemoApp.sessiontoken = call.argument("token");

                Intent intent = new Intent(MainActivity.this, SimpleNavActivity.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
                startActivity(intent);
//                result.success("ActivityStarted");
            }
            if (call.method.equals("sendTokenplace")) {
                KinesisVideoWebRtcDemoApp.result = result;
                KinesisVideoWebRtcDemoApp.username = call.argument("username");
                KinesisVideoWebRtcDemoApp.password = call.argument("password");
                KinesisVideoWebRtcDemoApp.streamId = call.argument("streamId");
                KinesisVideoWebRtcDemoApp.sessiontoken = call.argument("token");
                Intent intent = new Intent(MainActivity.this, SimpleNavActivityPlacement.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
                startActivity(intent);
//                result.success("ActivityStarted");
            }
            else  if (call.method.equals("helloFromNativeCode")) {
                String greetings = "hello";
                result.success(greetings);
              }

            
          
            
            else {
                result.notImplemented();
            }
        });

    }

}



