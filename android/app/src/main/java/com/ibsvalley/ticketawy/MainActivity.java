package com.ibsvalley.ticketawy;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.emeint.android.fawryplugin.Plugininterfacing.FawrySdk;
import com.emeint.android.fawryplugin.Plugininterfacing.PayableItem;
import com.emeint.android.fawryplugin.exceptions.FawryException;
import com.emeint.android.fawryplugin.interfaces.FawrySdkCallback;
import com.emeint.android.fawryplugin.managers.FawryPluginAppClass;
import com.emeint.android.fawryplugin.utils.UiUtils;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.http.Field;

import static com.emeint.android.fawryplugin.Plugininterfacing.FawrySdk.language;

public class MainActivity extends FlutterActivity {

    private static final int requestId = 666;
    private final int CARD_TOKENIZER_REQUEST = 1024;

    private static final String CHANNEL = "fawry";
    MethodChannel.Result result;
    private double total_price;
    private String merchantRefNumber;
    private String trxId1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        FawrySdk.init(FawrySdk.Styles.STYLE1);
        GeneratedPluginRegistrant.registerWith(this);
        // FawryPluginAppClass.enableLogging = false;
        initFawry();
        Log.i("abdo", "abdo " + "onCreate");

    }

    public void initFawry() {
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    if (methodCall.method.equals("initFawry")) {
                        Log.i("AASSCC", "onCreate: " + methodCall.arguments + new Gson().toJson(methodCall.arguments));
                        total_price = methodCall.argument("total_price");
                        merchantRefNumber = methodCall.argument("id");
                        String merchantID = "1tSa6uxz2nSIrOkfUERuTw==";
                        List<PayableItem> items = new ArrayList<>();

                        Item item = new Item();
                        item.setPrice(String.valueOf(total_price));
                        item.setDescription("test2");
                        item.setQty("1");
                        item.setSku("1");
                        items.add(item);


                        try {

                            Log.i("dfd", "onCreate2: " + "try");

                            FawrySdk.initialize(MainActivity.this,
                                    "https://atfawry.fawrystaging.com",
                                    new FawrySdkCallback() {
                                        public void onSuccess(String trxId, Object customParams) {
                                            Log.i("dfd", "onCreate: " + "onSuccess");
//                                            Toast.makeText(MainActivity.this, trxId, Toast.LENGTH_SHORT).show();
                                            Log.i("gggg", "onSuccess: " + trxId + customParams);
                                            trxId1 = trxId;
//                                            completedMethod();


//
                                            Map<String,String> stringStringMap=new HashMap<>();
                                            stringStringMap.put("Paymentresult","true");
                                            stringStringMap.put("transaction_Id",merchantRefNumber);
                                            stringStringMap.put("payment_type","Fawry");
                                            stringStringMap.put("fawryRefNumber",trxId);


                                            result.success(stringStringMap);


                                        }

                                        @Override
                                        public void onFailure(String errorMessage) {
                                            Log.i("dfd", "onCreate: " + "onFailure");
//                                            Toast.makeText(MainActivity.this, errorMessage, Toast.LENGTH_SHORT).show();
                                        result.error(null,null,null);
                                        }

                                    }, merchantID, merchantRefNumber, items,
                                    FawrySdk.Language.EN,
                                    requestId, null, new UUID(1, 2));
                            Log.i("dfd", "onCreate2: " + "try2");

                        } catch (FawryException e) {
                            e.printStackTrace();
                            Log.i("dfd", "onCreate2: " + e.getExceptionMessage());
                        }
                        FawrySdk.startPaymentActivity(this);
                    }
                }
        );
    }

    public void initFawry2() {
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    if (methodCall.method.equals("initFawry")) {
                        Log.i("AASSCC", "onCreate: " + methodCall.arguments + new Gson().toJson(methodCall.arguments));
                        total_price = methodCall.argument("total_price");
                        merchantRefNumber = methodCall.argument("id");
                        String merchantID = "1tSa6uxz2nSIrOkfUERuTw==";
                        List<PayableItem> items = new ArrayList<>();

                        Item item = new Item();
                        item.setPrice(String.valueOf(total_price));
                        item.setDescription("test2");
                        item.setQty("1");
                        item.setSku("1");
                        items.add(item);

                        FawryPluginAppClass.enableLogging = false;


                        try {

                            Log.i("dfd", "onCreate2: " + "try");

                            FawrySdk.initialize(MainActivity.this,
                                    "https://atfawry.fawrystaging.com",
                                    new FawrySdkCallback() {
                                        public void onSuccess(String trxId, Object customParams) {
                                            Log.i("dfd", "onCreate: " + "onSuccess");
//                                            Toast.makeText(MainActivity.this, trxId, Toast.LENGTH_SHORT).show();
                                            Log.i("gggg", "onSuccess: " + trxId + customParams);
                                            trxId1 = trxId;
                                            completedMethod();
                                            result.success(5);

                                        }

                                        @Override
                                        public void onFailure(String errorMessage) {
                                            Log.i("dfd", "onCreate: " + "onFailure");
//                                            Toast.makeText(MainActivity.this, errorMessage, Toast.LENGTH_SHORT).show();
                                        }

                                    }, merchantID, merchantRefNumber, items,
                                    FawrySdk.Language.EN,
                                    requestId, null, new UUID(1, 2));
                            Log.i("dfd", "onCreate2: " + "try2");

                        } catch (FawryException e) {
                            e.printStackTrace();
                            Log.i("dfd", "onCreate2: " + e.getExceptionMessage());
                        }
                        FawrySdk.startPaymentActivity(this);
                    }
                }
        );
    }

    public void initCardSDK() {
        String merchantID = "1tSa6uxz2nSIrOkfUERuTw==";
        String serverUrl = "https://atfawry.fawrystaging.com";
        String merchantRefNumber = randomAlphaNumeric(16);
        String customerMobile = "01226968664";
        String customerEmail = "Mina.Nabil@fawry.com";


        try {
            FawrySdk.initializeCardTokenizer(MainActivity.this, serverUrl, new FawrySdkCallback() {
                        @Override
                        public void onSuccess(String s, Object o) {

                        }

                        @Override
                        public void onFailure(String s) {

                        }
                    }, merchantID, merchantRefNumber,
                    customerMobile, customerEmail, FawrySdk.Language.EN, CARD_TOKENIZER_REQUEST, null, new UUID(1, 2));
        } catch (FawryException e) {
            UiUtils.showDialog(MainActivity.this, e, false);
            e.printStackTrace();
        }
    }

    private void completedMethod() {
//        Log.i("sdsadsa", "completedMethod: ");
//        Retrofit.Builder builder = new Retrofit.Builder()
//                .baseUrl("http://40.85.116.121:8607/api/")
//                .addConverterFactory(GsonConverterFactory.create());
//        Retrofit build = builder.build();
//        Api appConnections = build.create(Api.class);
//
//        Call<ResponeCompleted> Callww = appConnections.responeCompleted(
//
//        Callww.enqueue(new Callback<ResponeCompleted>() {
//            @Override
//            public void onResponse(Call<ResponeCompleted> call, Response<ResponeCompleted> response) {
//                if (response.isSuccessful()) {
////                    Toast.makeText(MainActivity.this, response.body().getUserMessage(), Toast.LENGTH_SHORT).show();
//                    Log.i("sddsf", "onResponse: " + response.body().getUserMessage());
//                }
//            }
//
//            @Override
//            public void onFailure(Call<ResponeCompleted> call, Throwable t) {
//
//            }
//        });


    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

    }

    private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    public static String randomAlphaNumeric(int count) {
        StringBuilder builder = new StringBuilder();
        while (count-- != 0) {
            int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());
            builder.append(ALPHA_NUMERIC_STRING.charAt(character));
        }
        return builder.toString();
    }

}