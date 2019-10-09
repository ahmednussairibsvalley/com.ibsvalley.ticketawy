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

public class MainActivity extends FlutterActivity  implements FawrySdkCallback {

  private static final int requestId = 666;

  private static final String CHANNEL = "fawry";

  private double total_price;
  private int merchantRefNumber;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            (methodCall, result) -> {
              if(methodCall.method.equals("initFawry")){
                Log.i("AASSCC", "onCreate: "+methodCall.arguments+new Gson().toJson(methodCall.arguments));
                total_price =   methodCall.argument("total_price");
                merchantRefNumber=methodCall.argument("id");
                String merchantID ="1tSa6uxz2nSIrOkfUERuTw==";
                List<PayableItem> items = new ArrayList<>();

                Item item = new Item();
                item.setPrice(String.valueOf(total_price));
                item.setDescription("test2");
                item.setQty("40");
                item.setSku("1");
                items.add(item);

                FawrySdk.init(FawrySdk.Styles.STYLE1);

                try {
                  Log.i("dfd", "onCreate2: " + "try");

                  FawrySdk.initialize(MainActivity.this,
                          "https://atfawry.fawrystaging.com",
                          new FawrySdkCallback() {
                            public void onSuccess(String trxId, Object customParams) {
                              Log.i("dfd", "onCreate: " + "onSuccess");
                              Toast.makeText(MainActivity.this, trxId, Toast.LENGTH_SHORT).show();
                            }

                            @Override
                            public void onFailure(String errorMessage) {
                              Log.i("dfd", "onCreate: " + "onFailure");
                              Toast.makeText(MainActivity.this, errorMessage, Toast.LENGTH_SHORT).show();
                            }

                          }, merchantID, String.valueOf(merchantRefNumber), items,
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


  @Override
  protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
    super.onActivityResult(requestCode, resultCode, data);

  }

  @Override
  public void onSuccess(String s, Object o) {

  }

  @Override
  public void onFailure(String s) {

  }
}