package com.ibsvalley.ticketawy;

import retrofit2.Call;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.POST;

public interface Api {
    @FormUrlEncoded
    @POST("Order/payment_successful")
    Call<ResponeCompleted> responeCompleted(@Field("Paymentresult") String Paymentresult,
                                            @Field("transaction_Id") String transaction_Id,
                                            @Field("payment_type") String payment_type
    );
}
