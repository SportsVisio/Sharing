package com.example.sports_visio.demoapp.utils;


import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;
import java.util.UUID;

public class Device {
    private UUID id;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
    private Object deletedAt;
    private String deviceID;
    private String name;
    private Eam stream;

    @JsonProperty("id")
    public UUID getID() { return id; }
    @JsonProperty("id")
    public void setID(UUID value) { this.id = value; }

    @JsonProperty("createdAt")
    public OffsetDateTime getCreatedAt() { return createdAt; }
    @JsonProperty("createdAt")
    public void setCreatedAt(OffsetDateTime value) { this.createdAt = value; }

    @JsonProperty("updatedAt")
    public OffsetDateTime getUpdatedAt() { return updatedAt; }
    @JsonProperty("updatedAt")
    public void setUpdatedAt(OffsetDateTime value) { this.updatedAt = value; }

    @JsonProperty("deletedAt")
    public Object getDeletedAt() { return deletedAt; }
    @JsonProperty("deletedAt")
    public void setDeletedAt(Object value) { this.deletedAt = value; }

    @JsonProperty("deviceId")
    public String getDeviceID() { return deviceID; }
    @JsonProperty("deviceId")
    public void setDeviceID(String value) { this.deviceID = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }

    @JsonProperty("stream")
    public Eam getStream() { return stream; }
    @JsonProperty("stream")
    public void setStream(Eam value) { this.stream = value; }
}
