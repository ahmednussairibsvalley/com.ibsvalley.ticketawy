package com.ibsvalley.ticketawy;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.emeint.android.fawryplugin.Plugininterfacing.FawrySdk;
import com.emeint.android.fawryplugin.Plugininterfacing.PayableItem;
import com.emeint.android.fawryplugin.exceptions.FawryException;
import com.emeint.android.fawryplugin.interfaces.FawrySdkCallback;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

import static com.emeint.android.fawryplugin.Plugininterfacing.FawrySdk.language;

public class MainActivity extends FlutterActivity {

    private static final int requestId = 666;

    private static final String CHANNEL = "fawry";

    private double total_price;
    private String merchantRefNumber;
    static PayableItem e = new PayableItem() {
        @Override
        public String getFawryItemDescription() {
            return "5";
        }

        @Override
        public String getFawryItemSKU() {
            return "54";
        }

        @Override
        public String getFawryItemPrice() {
            return "1";
        }

        @Override
        public String getFawryItemQuantity() {
            return "1";
        }
    };
    private String trxId1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    if (methodCall.method.equals("initFawry")) {
                        Log.i("AASSCC", "onCreate: " + methodCall.arguments + new Gson().toJson(methodCall.arguments));
                        total_price = methodCall.argument("total_price");
                        merchantRefNumber = methodCall.argument("id");
                        String merchantID = "1tSa6uxz2nSIrOkfUERuTw==";
                        List<PayableItem> items = new ArrayList<>();

                        Item item = new Item();
                        item.setPrice(String.valueOf(total_price - 1));
                        item.setDescription("test2");
                        item.setQty("1");
                        item.setSku("1");
                        items.add(item);
                        items.add(e);


                        FawrySdk.init(FawrySdk.Styles.STYLE1);

                        try {
                            Log.i("dfd", "onCreate2: " + "try");

                            FawrySdk.initialize(MainActivity.this,
                                    "https://atfawry.fawrystaging.com",
                                    new FawrySdkCallback() {
                                        public void onSuccess(String trxId, Object customParams) {
                                            Log.i("dfd", "onCreate: " + "onSuccess");
                                            Toast.makeText(MainActivity.this, trxId, Toast.LENGTH_SHORT).show();
                                            Log.i("gggg", "onSuccess: " + trxId + customParams);
                                            trxId1 = trxId;
                                            completedMethod();
                                        }

                                        @Override
                                        public void onFailure(String errorMessage) {
                                            Log.i("dfd", "onCreate: " + "onFailure");
                                            Toast.makeText(MainActivity.this, errorMessage, Toast.LENGTH_SHORT).show();
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

    private void completedMethod() {
        Log.i("sdsadsa", "completedMethod: ");
        Retrofit.Builder builder = new Retrofit.Builder()
                .baseUrl("40.85.116.121:8607/api/")
                .addConverterFactory(GsonConverterFactory.create());
        Retrofit build = builder.build();
        Api appConnections = build.create(Api.class);

        Call<ResponeCompleted> Callww = appConnections.responeCompleted("true", trxId1, String.valueOf(2));
        Callww.enqueue(new Callback<ResponeCompleted>() {
            @Override
            public void onResponse(Call<ResponeCompleted> call, Response<ResponeCompleted> response) {
                if (response.isSuccessful()) {
                    Toast.makeText(MainActivity.this, response.body().getUserMessage(), Toast.LENGTH_SHORT).show();
                    Log.i("sddsf", "onResponse: "+response.body().getUserMessage());
                }
            }

            @Override
            public void onFailure(Call<ResponeCompleted> call, Throwable t) {

            }
        });


    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

    }

}