package com.lumin824.qq;

import android.content.Intent;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import com.tencent.tauth.Tencent;
import com.tencent.tauth.IUiListener;
import com.tencent.tauth.UiError;

import org.json.JSONException;
import org.json.JSONObject;

public class QQModule extends ReactContextBaseJavaModule implements ActivityEventListener, IUiListener {

  public static Tencent mTencent;

  private Promise loginPromise;

  @Override
  public String getName() {
    return "QQModule";
  }

  public QQModule(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  public void initialize(){
    if(mTencent == null){
      mTencent = Tencent.createInstance(BuildConfig.APP_ID, getReactApplicationContext().getApplicationContext());
    }
    getReactApplicationContext().addActivityEventListener(this);
  }

  @Override
  public void onCatalystInstanceDestroy(){
    if(mTencent != null){
      mTencent = null;
    }
    getReactApplicationContext().removeActivityEventListener(this);
    super.onCatalystInstanceDestroy();
  }

  @Override
  public void onActivityResult(int requestCode, int resultCode, Intent data) {
    Tencent.onActivityResultData(requestCode, resultCode, data, this);
  }

  @ReactMethod
  public void getImageForFont(Callback callback) {
    callback.invoke(null, "ok");
  }

  @ReactMethod
  public void login(String scopes, Promise promise){
    if(!mTencent.isSessionValid()){
      loginPromise = promise;
      mTencent.login(getCurrentActivity(), scopes, this);
    } else {

    }
  }

  @Override
  public void onComplete(Object o) {
    JSONObject json = (JSONObject)o;
    if(loginPromise != null){
      try {
        String openid = json.getString("openid");
        loginPromise.resolve(openid);
      } catch (JSONException e){
        loginPromise.reject("except", e.getMessage());
      }
      loginPromise = null;
    }
  }

  @Override
  public void onError(UiError uiError) {
    if(loginPromise != null){
      loginPromise.reject("error", "error");
      loginPromise = null;
    }
  }

  @Override
  public void onCancel() {
    if(loginPromise != null){
      loginPromise.reject("cancel", "cancel");
      loginPromise = null;
    }
  }
}
