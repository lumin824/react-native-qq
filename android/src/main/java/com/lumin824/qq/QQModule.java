package com.lumin824.rn.qq;

import android.content.Intent;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import com.tencent.tauth.Tencent;
import com.tencent.tauth.IUiListener;
import com.tencent.tauth.UiError;

public class QQModule extends ReactContextBaseJavaModule implements ActivityEventListener {

  public static final String REACT_CLASS = "RNQQModule";

  public static Tencent mTencent;

  public IUiListener mUiListener;

  private String appId;

  @Override
  public String getName() {
    return REACT_CLASS;
  }

  public QQModule(ReactApplicationContext reactContext) {
    super(reactContext);

    try{
      ApplicationInfo appInfo = reactContext.getPackageManager().getApplicationInfo(reactContext.getPackageName(), PackageManager.GET_META_DATA);
      appId = appInfo.metaData.get("QQ_APPID").toString();
    } catch (PackageManager.NameNotFoundException e){

    }
  }

  @Override
  public void initialize(){
    if(mTencent == null){
      mTencent = Tencent.createInstance(appId, getReactApplicationContext().getApplicationContext());
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
    if(mUiListener != null){
      Tencent.onActivityResultData(requestCode, resultCode, data, mUiListener);
    }
  }

  @ReactMethod
  public void getImageForFont(Callback callback) {
    callback.invoke(null, "ok");
  }

  @ReactMethod
  public void login(String scopes, final Callback callback){
    if(!mTencent.isSessionValid()){

      mUiListener = new IUiListener(){
        @Override
        public void onComplete(Object response){
          callback.invoke("", response.toString());
        }
        @Override
        public void onError(UiError e){
          callback.invoke("error", e.errorMessage);
        }
        @Override
        public void onCancel(){
          callback.invoke("cancel");
        }
      };

      mTencent.login(getCurrentActivity(), scopes, mUiListener);
    } else {

    }
  }

}
