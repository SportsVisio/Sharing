package com.example.sports_visio.demoapp.utils;

import com.example.sports_visio.demoapp.utils.Device;
import com.example.sports_visio.demoapp.utils.Eam;
import com.example.sports_visio.demoapp.utils.League;
import com.example.sports_visio.demoapp.utils.ScheduledGame;
import com.fasterxml.jackson.annotation.*;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

public class AccountModel {
    private UUID id;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;
    private Boolean inactive;
    private List<League> leagues;
    private List<Eam> teams;
    private List<Object> members;
    private List<Device> devices;
    private List<ScheduledGame> scheduledGames;

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

    @JsonProperty("inactive")
    public Boolean getInactive() { return inactive; }
    @JsonProperty("inactive")
    public void setInactive(Boolean value) { this.inactive = value; }

    @JsonProperty("leagues")
    public List<League> getLeagues() { return leagues; }
    @JsonProperty("leagues")
    public void setLeagues(List<League> value) { this.leagues = value; }

    @JsonProperty("teams")
    public List<Eam> getTeams() { return teams; }
    @JsonProperty("teams")
    public void setTeams(List<Eam> value) { this.teams = value; }

    @JsonProperty("members")
    public List<Object> getMembers() { return members; }
    @JsonProperty("members")
    public void setMembers(List<Object> value) { this.members = value; }

    @JsonProperty("devices")
    public List<Device> getDevices() { return devices; }
    @JsonProperty("devices")
    public void setDevices(List<Device> value) { this.devices = value; }

    @JsonProperty("scheduledGames")
    public List<ScheduledGame> getScheduledGames() { return scheduledGames; }
    @JsonProperty("scheduledGames")
    public void setScheduledGames(List<ScheduledGame> value) { this.scheduledGames = value; }
}
