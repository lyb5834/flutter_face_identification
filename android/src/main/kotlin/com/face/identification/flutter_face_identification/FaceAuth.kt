package com.face.identification.flutter_face_identification

import android.app.Activity
import android.util.Log
import com.sheca.auth.h5.util.AuthResultBean
import com.sheca.auth.h5.util.CaAuthUi

object FaceAuth {
    private const val TAG = "FaceAuth"

    fun startFaceAuth(context: Activity?, url: String?, iFaceAuth: IFaceAuth) {
        CaAuthUi.startAuthActivity(context, url) { resultBean: AuthResultBean ->
            Log.d(TAG, "AuthResultBean $resultBean")
            Log.d(TAG, "code ${resultBean.code}")
            Log.d(TAG, "state ${resultBean.state}")
            iFaceAuth.onResult(resultBean.code,resultBean.state)
        }
    }

    interface IFaceAuth {
        fun onResult(code: String, state: String)
    }

}