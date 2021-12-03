package com.example.sports_visio.demoapp.utils;

import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

public class ScheduledGame {
    private UUID id;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
    private Long startTime;
    private Long endTime;
    private Description description;
    private List<Object> teamGameAssn;
    private List<DeviceGameAssn> deviceGameAssn;

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

    @JsonProperty("startTime")
    public Long getStartTime() { return startTime; }
    @JsonProperty("startTime")
    public void setStartTime(Long value) { this.startTime = value; }

    @JsonProperty("endTime")
    public Long getEndTime() { return endTime; }
    @JsonProperty("endTime")
    public void setEndTime(Long value) { this.endTime = value; }

    @JsonProperty("description")
    public Description getDescription() { return description; }
    @JsonProperty("description")
    public void setDescription(Description value) { this.description = value; }

    @JsonProperty("teamGameAssn")
    public List<Object> getTeamGameAssn() { return teamGameAssn; }
    @JsonProperty("teamGameAssn")
    public void setTeamGameAssn(List<Object> value) { this.teamGameAssn = value; }

    @JsonProperty("deviceGameAssn")
    public List<DeviceGameAssn> getDeviceGameAssn() { return deviceGameAssn; }
    @JsonProperty("deviceGameAssn")
    public void setDeviceGameAssn(List<DeviceGameAssn> value) { this.deviceGameAssn = value; }
}
