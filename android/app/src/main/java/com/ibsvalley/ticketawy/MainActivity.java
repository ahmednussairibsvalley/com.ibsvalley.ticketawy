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

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final int requestId = 666;

  private static final String CHANNEL = "fawry";

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
      return "78";
    }

    @Override
    public String getFawryItemQuantity() {
      return "3";
    }

  };

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            (methodCall, result) -> {
              if(methodCall.method.equals("initFawry")){
                List<PayableItem> t = new ArrayList<>();
                t.add(e);

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

                          }, "1tSa6uxz2nSIrOkfUERuTw==", "10", t,
                          FawrySdk.Language.EN,
                          requestId, null, new UUID(10, 10));
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
}