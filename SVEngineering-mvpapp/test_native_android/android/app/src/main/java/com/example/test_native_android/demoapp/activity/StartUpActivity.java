package com.example.test_native_android.demoapp.activity;

import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.amazonaws.mobile.client.AWSMobileClient;
import com.amazonaws.mobile.client.Callback;
import com.amazonaws.mobile.client.SignInUIOptions;
import com.amazonaws.mobile.client.UserStateDetails;
import com.example.test_native_android.R;
import com.example.test_native_android.demoapp.utils.ActivityUtils;

public class StartUpActivity extends AppCompatActivity {
    private static final String TAG = StartUpActivity.class.getSimpleName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        final AWSMobileClient auth = AWSMobileClient.getInstance();
        final AppCompatActivity thisActivity = this;

        AsyncTask.execute(new Runnable() {
            @Override
            public void run() {
                if (auth.isSignedIn()) {
                    ActivityUtils.startActivity(thisActivity, SimpleNavActivity.class);
                } else {
                    auth.showSignIn(thisActivity,
                            SignInUIOptions.builder()
                                    .logo(R.mipmap.kinesisvideo_logo)
                                    .backgroundColor(Color.WHITE)
                                    .nextActivity(SimpleNavActivity.class)
                                    .build(),
                            new Callback<UserStateDetails>() {
                                @Override
                                public void onResult(UserStateDetails result) {
                                    Log.d(TAG, "onResult: User signed-in " + result.getUserState());
                                }

                                @Override
                                public void onError(final Exception e) {
                                    runOnUiThread(new Runnable() {
                                        @Override
                                        public void run() {
                                            Log.e(TAG, "onError: User sign-in error", e);
                                            Toast.makeText(StartUpActivity.this, "User sign-in error: " + e.getMessage(), Toast.LENGTH_LONG).show();
                                        }
                                    });
                                }
                            });
                }
            }
        });
    }
}