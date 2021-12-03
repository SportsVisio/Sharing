package com.example.sports_visio.demoapp.utils;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;
import java.util.UUID;

public class Eam {
    private UUID id;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
    private Object deletedAt;
    private String streamName;
    private String name;

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

    @JsonProperty("streamName")
    public String getStreamName() { return streamName; }
    @JsonProperty("streamName")
    public void setStreamName(String value) { this.streamName = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
