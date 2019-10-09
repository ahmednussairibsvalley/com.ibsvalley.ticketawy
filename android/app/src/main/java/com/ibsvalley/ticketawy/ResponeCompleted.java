package com.ibsvalley.ticketawy;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class ResponeCompleted {


    @SerializedName("id")
    @Expose
    private String id;
    @SerializedName("result")
    @Expose
    private Boolean result;
    @SerializedName("user_Message")
    @Expose
    private String userMessage;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Boolean getResult() {
        return result;
    }

    public void setResult(Boolean result) {
        this.result = result;
    }

    public String getUserMessage() {
        return userMessage;
    }

    public void setUserMessage(String userMessage) {
        this.userMessage = userMessage;
    }

}
