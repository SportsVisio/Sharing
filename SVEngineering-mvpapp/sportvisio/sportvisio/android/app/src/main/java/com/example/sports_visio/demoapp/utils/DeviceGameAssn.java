package com.example.sports_visio.demoapp.utils;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

public class DeviceGameAssn {
    private UUID id;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
    private Object deletedAt;
    private String videoID;
    private Boolean isActive;
    private Long startTime;
    private Long endTime;
    private List<Object> annotations;

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

    @JsonProperty("videoId")
    public String getVideoID() { return videoID; }
    @JsonProperty("videoId")
    public void setVideoID(String value) { this.videoID = value; }

    @JsonProperty("isActive")
    public Boolean getIsActive() { return isActive; }
    @JsonProperty("isActive")
    public void setIsActive(Boolean value) { this.isActive = value; }

    @JsonProperty("startTime")
    public Long getStartTime() { return startTime; }
    @JsonProperty("startTime")
    public void setStartTime(Long value) { this.startTime = value; }

    @JsonProperty("endTime")
    public Long getEndTime() { return endTime; }
    @JsonProperty("endTime")
    public void setEndTime(Long value) { this.endTime = value; }

    @JsonProperty("annotations")
    public List<Object> getAnnotations() { return annotations; }
    @JsonProperty("annotations")
    public void setAnnotations(List<Object> value) { this.annotations = value; }
}
