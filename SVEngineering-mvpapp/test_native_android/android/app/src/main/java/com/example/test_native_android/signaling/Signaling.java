package com.example.test_native_android.signaling;

import com.example.test_native_android.signaling.model.Event;

public interface Signaling {

    void onSdpOffer(Event event);

    void onSdpAnswer(Event event);

    void onIceCandidate(Event event);

    void onError(Event event);

    void onException(Exception e);
}

