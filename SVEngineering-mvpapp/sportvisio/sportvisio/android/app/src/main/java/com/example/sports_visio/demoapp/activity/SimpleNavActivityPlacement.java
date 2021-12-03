package com.example.sports_visio.demoapp.activity;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.Manifest;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.MenuItem;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;

import com.amazonaws.mobile.client.AWSMobileClient;
import com.amazonaws.mobile.client.Callback;
import com.amazonaws.mobile.client.SignInUIOptions;
import com.amazonaws.mobile.client.UserStateDetails;
import com.amazonaws.mobile.client.results.SignInResult;
import com.example.sports_visio.R;
import com.example.sports_visio.demoapp.KinesisVideoWebRtcDemoApp;
import com.example.sports_visio.demoapp.fragment.StreamWebRtcConfigurationFragment;
import com.example.sports_visio.demoapp.fragment.StreamWebRtcConfigurationPlacementFragment;
import com.google.android.material.navigation.NavigationView;

import org.jetbrains.annotations.NotNull;

@SuppressWarnings("WeakerAccess")
public class SimpleNavActivityPlacement extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener  {
    private static final String TAG = SimpleNavActivity.class.getSimpleName();

    private StreamWebRtcConfigurationPlacementFragment streamFragment;
    private boolean hasCameraPermission = false;
    private boolean hasRecordAudioPermission = false;

    @SuppressWarnings("deprecation")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        initAwsMobileClient();
        setContentView(R.layout.activity_simple_nav);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.setDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        if (savedInstanceState != null) {
            streamFragment = (StreamWebRtcConfigurationPlacementFragment) getSupportFragmentManager().findFragmentByTag(StreamWebRtcConfigurationPlacementFragment.class.getName());
        }
        // Video only
        this.startConfigFragment();
    }

    void initAwsMobileClient() {
        final AWSMobileClient auth = AWSMobileClient.getInstance();
        //  Toast.makeText(getApplicationContext(), KinesisVideoWebRtcDemoApp.username,Toast.LENGTH_LONG).show();
        Log.v("javajava",KinesisVideoWebRtcDemoApp.username);
        AsyncTask.execute(() -> auth.signIn("tester", "Test@123", null, new Callback<SignInResult>() {
            @Override
            public void onResult(SignInResult result) {

                Log.d(TAG, "onResult: User signed-in " + result.getSignInState());
                if (hasCameraPermission && hasRecordAudioPermission) {
                    streamFragment.startMasterActivity();
                } else {
                    checkPermissions();
                }

            }

            @Override
            public void onError(Exception e) {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        Log.e(TAG, "onError: User sign-in error", e);
                        Toast.makeText(SimpleNavActivityPlacement.this, "User sign-in error: " + e.getMessage(), Toast.LENGTH_LONG).show();
                    }
                });
            }
        }));
    }

    void checkPermissions() {
        hasCameraPermission = ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED;
        hasRecordAudioPermission = ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED;
        if (!hasCameraPermission || !hasRecordAudioPermission) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO}, 9393);
        }
    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.nav_logout) {
            AWSMobileClient.getInstance().signOut();
            AWSMobileClient.getInstance().showSignIn(this,
                    SignInUIOptions.builder()
                            .logo(R.mipmap.kinesisvideo_logo)
                            .backgroundColor(Color.WHITE)
                            .nextActivity(SimpleNavActivity.class)
                            .build(),
                    new Callback<UserStateDetails>() {
                        @Override
                        public void onResult(UserStateDetails result) {
                            Log.d(TAG, "onResult: User sign-in " + result.getUserState());
                        }

                        @Override
                        public void onError(Exception e) {
                            Log.e(TAG, "onError: User sign-in", e);
                        }
                    });
        }

        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    public void startFragment(Fragment fragment) {
        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentManager.beginTransaction().replace(R.id.content_simple, fragment, StreamWebRtcConfigurationPlacementFragment.class.getName()).commit();
    }

    public void startConfigFragment() {
        try {
            if (streamFragment == null) {
                streamFragment = StreamWebRtcConfigurationPlacementFragment.newInstance(this);
                this.startFragment(streamFragment);
            }
        } catch (Exception e) {
            Log.e(TAG, "Failed to go back to configure stream.");
            e.printStackTrace();
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull @NotNull String[] permissions, @NonNull @NotNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == 9393 && grantResults.length > 1) {
            boolean cameraPermission = grantResults[0] == PackageManager.PERMISSION_GRANTED;
            boolean audioPermission = grantResults[1] == PackageManager.PERMISSION_GRANTED;
            if (!audioPermission) {
                requestPermissions(new String[]{Manifest.permission.RECORD_AUDIO}, 9393);
            } else if (!cameraPermission) {
                requestPermissions(new String[]{Manifest.permission.CAMERA}, 9393);
            } else {
                streamFragment.startMasterActivity();
            }
        }
    }
}
