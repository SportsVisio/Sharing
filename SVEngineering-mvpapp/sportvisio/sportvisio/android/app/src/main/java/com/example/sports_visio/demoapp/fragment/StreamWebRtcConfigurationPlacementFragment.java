package com.example.sports_visio.demoapp.fragment;

import android.Manifest;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.provider.Settings;
import android.util.Log;
import android.util.SparseBooleanArray;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckedTextView;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.Fragment;

import com.amazonaws.regions.Region;
import com.amazonaws.services.kinesisvideo.AWSKinesisVideoClient;
import com.amazonaws.services.kinesisvideo.model.ChannelRole;
import com.amazonaws.services.kinesisvideo.model.CreateSignalingChannelRequest;
import com.amazonaws.services.kinesisvideo.model.CreateSignalingChannelResult;
import com.amazonaws.services.kinesisvideo.model.DescribeSignalingChannelRequest;
import com.amazonaws.services.kinesisvideo.model.DescribeSignalingChannelResult;
import com.amazonaws.services.kinesisvideo.model.GetSignalingChannelEndpointRequest;
import com.amazonaws.services.kinesisvideo.model.GetSignalingChannelEndpointResult;
import com.amazonaws.services.kinesisvideo.model.ResourceEndpointListItem;
import com.amazonaws.services.kinesisvideo.model.ResourceNotFoundException;
import com.amazonaws.services.kinesisvideo.model.SingleMasterChannelEndpointConfiguration;
import com.amazonaws.services.kinesisvideosignaling.AWSKinesisVideoSignalingClient;
import com.amazonaws.services.kinesisvideosignaling.model.GetIceServerConfigRequest;
import com.amazonaws.services.kinesisvideosignaling.model.GetIceServerConfigResult;
import com.amazonaws.services.kinesisvideosignaling.model.IceServer;
import com.example.sports_visio.R;
import com.example.sports_visio.constants.ApiEndpoints;
import com.example.sports_visio.demoapp.KinesisVideoWebRtcDemoApp;
import com.example.sports_visio.demoapp.activity.SimpleNavActivity;
import com.example.sports_visio.demoapp.activity.SimpleNavActivityPlacement;
import com.example.sports_visio.demoapp.activity.WebRtcActivity;
import com.example.sports_visio.demoapp.activity.WebRtcActivityPlacement;

import org.json.JSONObject;

import java.io.IOException;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

import okhttp3.Call;
import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class StreamWebRtcConfigurationPlacementFragment extends Fragment {
    OkHttpClient okHttpClient = new OkHttpClient();

    private static final String TAG = StreamWebRtcConfigurationPlacementFragment.class.getSimpleName();

    private static final String KEY_CHANNEL_NAME = "channelName";
    public static final String KEY_CLIENT_ID = "clientId";
    public static final String KEY_REGION = "region";
    public static final String KEY_CHANNEL_ARN = "channelArn";
    public static final String KEY_WSS_ENDPOINT = "wssEndpoint";
    public static final String KEY_IS_MASTER = "isMaster";
    public static final String KEY_ICE_SERVER_USER_NAME = "iceServerUserName";
    public static final String KEY_ICE_SERVER_PASSWORD = "iceServerPassword";
    public static final String KEY_ICE_SERVER_TTL = "iceServerTTL";
    public static final String KEY_ICE_SERVER_URI = "iceServerUri";
    public static final String KEY_CAMERA_FRONT_FACING = "cameraFrontFacing";

    private static final String KEY_SEND_VIDEO = "sendVideo";
    public static final String KEY_SEND_AUDIO = "sendAudio";

    private static final String[] WEBRTC_OPTIONS = {
            "Send Video",
            "Send Audio",
    };

    private static final String[] KEY_OF_OPTIONS = {
            KEY_SEND_VIDEO,
            KEY_SEND_AUDIO,
    };


    private EditText mChannelName;
    private EditText mClientId;
    private EditText mRegion;
    private Spinner mCameras;
    private final List<ResourceEndpointListItem> mEndpointList = new ArrayList<>();
    private final List<IceServer> mIceServerList = new ArrayList<>();
    private String mChannelArn = null;
    private ListView mOptions;

    private SimpleNavActivityPlacement navActivity;

    public static StreamWebRtcConfigurationPlacementFragment newInstance(SimpleNavActivityPlacement navActivity) {
        StreamWebRtcConfigurationPlacementFragment s = new StreamWebRtcConfigurationPlacementFragment();
        s.navActivity = navActivity;
        return s;
    }

    @Override
    public View onCreateView(final LayoutInflater inflater,
                             final ViewGroup container,
                             final Bundle savedInstanceState) {
        if (getActivity() != null) {
            getActivity().setTitle(getActivity().getString(R.string.title_fragment_channel));
        }

        return inflater.inflate(R.layout.fragment_stream_webrtc_configuration, container, false);
    }

    @Override
    public void onViewCreated(final View view, Bundle savedInstanceState) {
        Button mStartMasterButton = view.findViewById(R.id.start_master);
        mStartMasterButton.setOnClickListener(startMasterActivityWhenClicked());
        Button mStartViewerButton = view.findViewById(R.id.start_viewer);
        mStartViewerButton.setOnClickListener(startViewerActivityWhenClicked());

        mChannelName = view.findViewById(R.id.channel_name);
        mClientId = view.findViewById(R.id.client_id);
        mRegion = view.findViewById(R.id.region);
        setRegionFromCognito();

        mOptions = view.findViewById(R.id.webrtc_options);
        mOptions.setAdapter(new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_multiple_choice, WEBRTC_OPTIONS) {
            @NonNull
            @Override
            public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
                if (convertView == null) {
                    View v = getLayoutInflater().inflate(android.R.layout.simple_list_item_multiple_choice, null);

                    final CheckedTextView ctv = v.findViewById(android.R.id.text1);
                    ctv.setText(WEBRTC_OPTIONS[position]);

                    // Send video is enabled by default and cannot uncheck
                    if (position == 0) {
                        ctv.setEnabled(false);
                        ctv.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                ctv.setChecked(true);
                            }
                        });
                    }
                    return v;
                }

                return convertView;
            }
        });
        mOptions.setItemsCanFocus(false);
        mOptions.setChoiceMode(ListView.CHOICE_MODE_MULTIPLE);
        mOptions.setItemChecked(0, true);

        mCameras = view.findViewById(R.id.camera_spinner);

        List<String> cameraList = new ArrayList<>(Arrays.asList("Front Camera", "Back Camera"));

        if (getContext() != null) {
            ArrayAdapter adapter = new ArrayAdapter<>(getContext(), android.R.layout.simple_spinner_dropdown_item,
                    cameraList);
            mCameras.setAdapter(adapter);
            mCameras.setSelection(adapter.getPosition("Back Camera"));
        }

        if (KinesisVideoWebRtcDemoApp.streamId != null) {
            mChannelName.setText(KinesisVideoWebRtcDemoApp.streamId);
            startMasterActivity();
        } else {
           // registerDeviceStream();
            RegisterDevice();
        }


    }


    private void setRegionFromCognito() {
        String region = KinesisVideoWebRtcDemoApp.getRegion();
        if (region != null) {
            mRegion.setText(region);
        }
    }

    private View.OnClickListener startMasterActivityWhenClicked() {
        return view -> startMasterActivity();
    }

    public void startMasterActivity() {
        String channelNameString = mChannelName.getText().toString();
        if (channelNameString != null && !channelNameString.isEmpty()) {
            updateSignalingChannelInfo(mRegion.getText().toString(),
                    channelNameString,
                    ChannelRole.MASTER);
            if (mChannelArn != null) {
                Bundle extras = setExtras(true);
                Intent intent = new Intent(getActivity(), WebRtcActivityPlacement.class);
                intent.putExtras(extras);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_TASK_ON_HOME);
                startActivity(intent);
                getActivity().finish();
            }
        }

    }

    private View.OnClickListener startViewerActivityWhenClicked() {
        return view -> startViewerActivity();
    }

    private void startViewerActivity() {
        String channelNameString = mChannelName.getText().toString();
        if (channelNameString != null && !channelNameString.isEmpty()) {
            updateSignalingChannelInfo(mRegion.getText().toString(),
                    mChannelName.getText().toString(),
                    ChannelRole.VIEWER);

            if (mChannelArn != null) {
                Bundle extras = setExtras(false);
                Intent intent = new Intent(getActivity(), WebRtcActivityPlacement.class);
                intent.putExtras(extras);
                startActivity(intent);
                getActivity().finish();

            }
        }
    }

    private Bundle setExtras(boolean isMaster) {
        String channelNameString = mChannelName.getText().toString();
        if (channelNameString != null && !channelNameString.isEmpty()) {
            final Bundle extras = new Bundle();
            final String channelName = mChannelName.getText().toString();
            final String clientId = mClientId.getText().toString();
            final String region = mRegion.getText().toString();

            extras.putString(KEY_CHANNEL_NAME, channelName);
            extras.putString(KEY_CLIENT_ID, clientId);
            extras.putString(KEY_REGION, region);
            extras.putString(KEY_REGION, region);
            extras.putString(KEY_CHANNEL_ARN, mChannelArn);
            extras.putBoolean(KEY_IS_MASTER, isMaster);

            if (mIceServerList.size() > 0) {
                ArrayList<String> userNames = new ArrayList<>(mIceServerList.size());
                ArrayList<String> passwords = new ArrayList<>(mIceServerList.size());
                ArrayList<Integer> ttls = new ArrayList<>(mIceServerList.size());
                ArrayList<List<String>> urisList = new ArrayList<>();
                for (IceServer iceServer : mIceServerList) {
                    userNames.add(iceServer.getUsername());
                    passwords.add(iceServer.getPassword());
                    ttls.add(iceServer.getTtl());
                    urisList.add(iceServer.getUris());
                }
                extras.putStringArrayList(KEY_ICE_SERVER_USER_NAME, userNames);
                extras.putStringArrayList(KEY_ICE_SERVER_PASSWORD, passwords);
                extras.putIntegerArrayList(KEY_ICE_SERVER_TTL, ttls);
                extras.putSerializable(KEY_ICE_SERVER_URI, urisList);
            } else {
                extras.putStringArrayList(KEY_ICE_SERVER_USER_NAME, null);
                extras.putStringArrayList(KEY_ICE_SERVER_PASSWORD, null);
                extras.putIntegerArrayList(KEY_ICE_SERVER_TTL, null);
                extras.putSerializable(KEY_ICE_SERVER_URI, null);
            }

            for (ResourceEndpointListItem endpoint : mEndpointList) {
                if (endpoint.getProtocol().equals("WSS")) {
                    extras.putString(KEY_WSS_ENDPOINT, endpoint.getResourceEndpoint());
                }
            }

            final SparseBooleanArray checked = mOptions.getCheckedItemPositions();
            for (int i = 0; i < mOptions.getCount(); i++) {
                extras.putBoolean(KEY_OF_OPTIONS[i], checked.get(i));
            }

            extras.putBoolean(KEY_CAMERA_FRONT_FACING, mCameras.getSelectedItem().equals("Front Camera"));
            return extras;
        }
        return null;
    }

    private AWSKinesisVideoClient getAwsKinesisVideoClient(final String region) {
        final AWSKinesisVideoClient awsKinesisVideoClient = new AWSKinesisVideoClient(
                KinesisVideoWebRtcDemoApp.getCredentialsProvider().getCredentials());
        awsKinesisVideoClient.setRegion(Region.getRegion(region));
        awsKinesisVideoClient.setSignerRegionOverride(region);
        awsKinesisVideoClient.setServiceNameIntern("kinesisvideo");
        return awsKinesisVideoClient;
    }

    private AWSKinesisVideoSignalingClient getAwsKinesisVideoSignalingClient(final String region, final String endpoint) {
        final AWSKinesisVideoSignalingClient client = new AWSKinesisVideoSignalingClient(
                KinesisVideoWebRtcDemoApp.getCredentialsProvider().getCredentials());
        client.setRegion(Region.getRegion(region));
        client.setSignerRegionOverride(region);
        client.setServiceNameIntern("kinesisvideo");
        client.setEndpoint(endpoint);
        return client;
    }

    private void updateSignalingChannelInfo(final String region, final String channelName, final ChannelRole role) {
        mEndpointList.clear();
        mIceServerList.clear();
        mChannelArn = null;
        UpdateSignalingChannelInfoTask task = new UpdateSignalingChannelInfoTask(this);
        try {
            task.execute(region, channelName, role).get();
        } catch (Exception e) {
            Log.e(TAG, "Failed to wait for response of UpdateSignalingChannelInfoTask", e);
        }
    }

    static class UpdateSignalingChannelInfoTask extends AsyncTask<Object, String, String> {
        final WeakReference<StreamWebRtcConfigurationPlacementFragment> mFragment;

        UpdateSignalingChannelInfoTask(final StreamWebRtcConfigurationPlacementFragment fragment) {
            mFragment = new WeakReference<>(fragment);
        }

        @Override
        protected String doInBackground(Object... objects) {
            final String region = (String) objects[0];
            final String channelName = (String) objects[1];
            final ChannelRole role = (ChannelRole) objects[2];
            AWSKinesisVideoClient awsKinesisVideoClient = null;
            try {
                awsKinesisVideoClient = mFragment.get().getAwsKinesisVideoClient(region);
            } catch (Exception e) {
                return "Create client failed with " + e.getLocalizedMessage();
            }

            try {
                DescribeSignalingChannelResult describeSignalingChannelResult = awsKinesisVideoClient.describeSignalingChannel(
                        new DescribeSignalingChannelRequest()
                                .withChannelName(channelName));

                Log.i(TAG, "Channel ARN is " + describeSignalingChannelResult.getChannelInfo().getChannelARN());
                mFragment.get().mChannelArn = describeSignalingChannelResult.getChannelInfo().getChannelARN();
            } catch (final ResourceNotFoundException e) {
                if (role.equals(ChannelRole.MASTER)) {
                    try {
                        CreateSignalingChannelResult createSignalingChannelResult = awsKinesisVideoClient.createSignalingChannel(
                                new CreateSignalingChannelRequest()
                                        .withChannelName(channelName));

                        mFragment.get().mChannelArn = createSignalingChannelResult.getChannelARN();
                    } catch (Exception ex) {
                        return "Create Signaling Channel failed with Exception " + ex.getLocalizedMessage();
                    }
                } else {
                    return "Signaling Channel " + channelName + " doesn't exist!";
                }
            } catch (Exception ex) {
                return "Describe Signaling Channel failed with Exception " + ex.getLocalizedMessage();
            }

            try {
                GetSignalingChannelEndpointResult getSignalingChannelEndpointResult = awsKinesisVideoClient.getSignalingChannelEndpoint(
                        new GetSignalingChannelEndpointRequest()
                                .withChannelARN(mFragment.get().mChannelArn)
                                .withSingleMasterChannelEndpointConfiguration(
                                        new SingleMasterChannelEndpointConfiguration()
                                                .withProtocols("WSS", "HTTPS")
                                                .withRole(role)));

                Log.i(TAG, "Endpoints " + getSignalingChannelEndpointResult.toString());
                mFragment.get().mEndpointList.addAll(getSignalingChannelEndpointResult.getResourceEndpointList());
            } catch (Exception e) {
                return "Get Signaling Endpoint failed with Exception " + e.getLocalizedMessage();
            }

            String dataEndpoint = null;
            for (ResourceEndpointListItem endpoint : mFragment.get().mEndpointList) {
                if (endpoint.getProtocol().equals("HTTPS")) {
                    dataEndpoint = endpoint.getResourceEndpoint();
                }
            }

            try {
                final AWSKinesisVideoSignalingClient awsKinesisVideoSignalingClient = mFragment.get().getAwsKinesisVideoSignalingClient(region, dataEndpoint);
                GetIceServerConfigResult getIceServerConfigResult = awsKinesisVideoSignalingClient.getIceServerConfig(
                        new GetIceServerConfigRequest().withChannelARN(mFragment.get().mChannelArn).withClientId(role.name()));
                mFragment.get().mIceServerList.addAll(getIceServerConfigResult.getIceServerList());
            } catch (Exception e) {
                return "Get Ice Server Config failed with Exception " + e.getLocalizedMessage();
            }

            return null;
        }

        @Override
        protected void onPostExecute(String result) {
            if (result != null) {
                AlertDialog.Builder diag = new AlertDialog.Builder(mFragment.get().getContext());
                diag.setPositiveButton("OK", null).setMessage(result).create().show();
            }
        }
    }

    void registerDeviceStream() {
        long timeStamp = TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis());
        String startTimeStamp = String.valueOf(timeStamp);
        String endTimeStamp = String.valueOf(timeStamp + 1);
        String deviceId = Settings.Secure.getString(getContext().getContentResolver(),
                Settings.Secure.ANDROID_ID);
        RequestBody requestBody = new FormBody.Builder()
                .add("videoId", "android-test-video" + startTimeStamp + endTimeStamp)
                .add("startTime", startTimeStamp)
                .add("endTime", endTimeStamp)
                .build();
        Request request = new Request.Builder()
                .url(ApiEndpoints.REGISTER_STREAM + "/" + deviceId)
                .post(requestBody)
                .build();

        okHttpClient.newCall(request).enqueue(new okhttp3.Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                call.cancel();
                e.printStackTrace();
                unregisterDeviceStream();
                Toast.makeText(getActivity(), "Failed to register stream", Toast.LENGTH_LONG);
            }

            @Override
            public void onResponse(Call call, Response response) {
                getActivity().runOnUiThread(() -> {
                    try {
                        if (response.code() != 201) {
                            throw new Exception("Failed to register stream");
                        }
                        String streamId = response.body().string();
                        Log.v("javajavastream",streamId);
                        //todo handle success
                        KinesisVideoWebRtcDemoApp.result.success(streamId);
                        mChannelName.setText(streamId);
                        if (ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED
                                || ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
                            ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO}, 9393);
                        } else {
                            startMasterActivity();
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                        Toast.makeText(getActivity(), "Failed to register stream", Toast.LENGTH_LONG).show();
                        unregisterDeviceStream();
                        getActivity().finish();
                    } catch (Exception e) {
                        e.printStackTrace();
                        Toast.makeText(getActivity(), "Failed to register stream", Toast.LENGTH_LONG).show();
                        unregisterDeviceStream();
                        getActivity().finish();
                    }
                });
            }
        });
    }
    void RegisterDevice() {
        long timeStamp = TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis());
        String startTimeStamp = String.valueOf(timeStamp);
        String endTimeStamp = String.valueOf(timeStamp + 1);
        String deviceId = Settings.Secure.getString(getContext().getContentResolver(),
                Settings.Secure.ANDROID_ID);
        Log.v("javadeviceid",deviceId+timeStamp);

        RequestBody requestBody = new FormBody.Builder()
                .add("accountId", "")
                .add("deviceId", deviceId+timeStamp)
                .add("name", "android-test-video" + startTimeStamp + endTimeStamp)

                .build();
        Request request = new Request.Builder()
                .header("Authorization", "Bearer "+KinesisVideoWebRtcDemoApp.sessiontoken)
                .url(ApiEndpoints.REGISTERDEVICE)
                .post(requestBody)
                .build();

        okHttpClient.newCall(request).enqueue(new okhttp3.Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                Log.v("javajavah","here1");

                unregisterDeviceStream();

                call.cancel();
            }

            @Override
            public void onResponse(Call call, Response response) {


                getActivity().runOnUiThread(() -> {
                    try {
                        if (response.code() != 201) {
                            throw new Exception("Failed to register stream");
                        }
                        String data=response.body().string().trim();
                        JSONObject jsonObject=new JSONObject(data);

                        String streamId = jsonObject.getString("id");
//                        JSONObject gameAssObj=jsonObject.optJSONObject("gameAssn");
//                        JSONObject gameObj=gameAssObj.optJSONObject("game");
//                        String gameId=gameObj.getString("id");


                        Log.v("javajavastream",streamId);
                       // Log.v("javajavaGameId",gameId);

                        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(getContext());
                        SharedPreferences.Editor editor = preferences.edit();
                        editor.putString("registerdevicid",streamId);
                        editor.apply();

                        //todo handle success
                        KinesisVideoWebRtcDemoApp.result.success(streamId);
                        mChannelName.setText(streamId);
                        if (ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED
                                || ContextCompat.checkSelfPermission(getActivity(), Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
                            ActivityCompat.requestPermissions(getActivity(), new String[]{Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO}, 9393);
                        } else {
                        //    startMasterActivity();
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                        Toast.makeText(getActivity(), "Failed to register stream", Toast.LENGTH_LONG).show();
                        Log.v("javajavah","here2");

                        unregisterDeviceStream();
                        getActivity().finish();
                    } catch (Exception e) {
                        e.printStackTrace();
                        Log.v("javajavaerror",e.getMessage());
                        Toast.makeText(getActivity(), "Failed to register stream", Toast.LENGTH_LONG).show();
                        Log.v("javajavah","here3");
                        unregisterDeviceStream();

                        getActivity().finish();

                    }
                });
            }

        });
    }

    void unregisterDeviceStream1() {
        Request request = new Request.Builder().url(ApiEndpoints.UNREGISTER_STREAM + "/" + Settings.Secure.getString(getContext().getContentResolver(),
                Settings.Secure.ANDROID_ID)).delete().build();
        okHttpClient.newCall(request).enqueue(new okhttp3.Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                call.cancel();
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                final String myResponse = response.body().string();
            }
        });

    }
    void unregisterDeviceStream(){
        SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(getContext());
        String registerdevicid = preferences.getString("registerdevicid", "");

        Log.v("javajavadevice","call"+registerdevicid);

        Request request = new Request.Builder() .header("Authorization", "Bearer "+KinesisVideoWebRtcDemoApp.sessiontoken)
                .url(ApiEndpoints.UNREGISTERDEVICE + "/" +registerdevicid).delete().build();
        okHttpClient.newCall(request).enqueue(new okhttp3.Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                call.cancel();
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                final String myResponse = response.body().string();
                Log.v("javajavadevice",myResponse);
            }
        });

    }
}
