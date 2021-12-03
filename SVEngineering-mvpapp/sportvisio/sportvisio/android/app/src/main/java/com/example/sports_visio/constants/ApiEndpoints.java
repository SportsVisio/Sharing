package com.example.sports_visio.constants;

public class ApiEndpoints {
    //public static String BASE_URL = "https://jefg6ib005.execute-api.us-east-1.amazonaws.com/qa";
    // public static String BASE_URL = "https://qa.sportsvisio-api.com";
    public static String BASE_URL = "https://dev.sportsvisio-api.com";


    public static String REGISTER_STREAM = BASE_URL + "/streams/register";
    public static String UNREGISTER_STREAM = BASE_URL + "/streams/unregister";
    public static String START_STREAM = BASE_URL + "/devices/stream/start";
    public static String STOP_STREAM = BASE_URL + "/devices/stream/stop";
    public static String REGISTERDEVICE = BASE_URL + "/devices/register";
    public static String UNREGISTERDEVICE = BASE_URL + "/devices/unregister";
    public static String DEVICEATTACH = BASE_URL + "/devices/attach";
    public static String DEVICEUNATTACH = BASE_URL + "/devices/update-attachment";
    public static String GETACCOUNTS = BASE_URL + "/account/";




}
