package com.example.sports_visio.demoapp.utils;

import java.io.IOException;
import com.fasterxml.jackson.annotation.*;

public enum Description {
    DESCRIPTION, EMPTY;

    @JsonValue
    public String toValue() {
        switch (this) {
            case DESCRIPTION: return "description";
            case EMPTY: return "";
        }
        return null;
    }

    @JsonCreator
    public static Description forValue(String value) throws IOException {
        if (value.equals("description")) return DESCRIPTION;
        if (value.equals("")) return EMPTY;
        throw new IOException("Cannot deserialize Description");
    }
}
