package com.example.sports_visio.signaling;

import com.example.sports_visio.signaling.model.Event;

public interface Signaling {

    void onSdpOffer(Event event);

    void onSdpAnswer(Event event);

    void onIceCandidate(Event event);

    void onError(Event event);

    void onException(Exception e);
}

