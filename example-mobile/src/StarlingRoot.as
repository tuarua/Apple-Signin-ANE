package {
import com.tuarua.AppleSignInANE;
import com.tuarua.applesigninane.AppleIDCredential;
import com.tuarua.applesigninane.AppleIDProviderCredentialState;
import com.tuarua.applesigninane.AuthorizationErrorCode;
import com.tuarua.applesigninane.AuthorizationScope;
import com.tuarua.applesigninane.UserDetectionStatus;
import com.tuarua.applesigninane.events.AppleSignInErrorEvent;
import com.tuarua.applesigninane.events.AppleSignInEvent;

import flash.desktop.NativeApplication;
import flash.events.Event;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.utils.Align;

import views.SimpleButton;

public class StarlingRoot extends Sprite {
    private var menuContainer:Sprite = new Sprite();
    private var signInBtn:SimpleButton = new SimpleButton("Sign In");
    private var getCredentialStateBtn:SimpleButton = new SimpleButton("Get Credential State");

    private var statusLabel:TextField;
    private var appleSignIn:AppleSignInANE;

    public function StarlingRoot() {
        super();
        TextField.registerCompositor(Fonts.getFont("fira-sans-semi-bold-13"), "Fira Sans Semi-Bold 13");
        NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);
    }

    public function start():void {
        appleSignIn = AppleSignInANE.appleSignIn;
        if (!appleSignIn.isSupported) return;
        appleSignIn.addEventListener(AppleSignInErrorEvent.ERROR, onError);
        appleSignIn.addEventListener(AppleSignInEvent.SUCCESS, onSuccess);
        initMenu();
    }

    private function initMenu():void {
        signInBtn.addEventListener(TouchEvent.TOUCH, onSignInClick);
        getCredentialStateBtn.addEventListener(TouchEvent.TOUCH, onGetCredentialStateClick);
        getCredentialStateBtn.x = signInBtn.x = (stage.stageWidth - 200) / 2;
        signInBtn.y = 80;
        getCredentialStateBtn.y = signInBtn.y + 75;

        statusLabel = new TextField(stage.stageWidth, 200, "");
        statusLabel.format.setTo(Fonts.NAME, 13, 0x222222, Align.CENTER, Align.TOP);
        statusLabel.touchable = false;
        statusLabel.y = getCredentialStateBtn.y + 75;
        menuContainer.addChild(signInBtn);
        menuContainer.addChild(getCredentialStateBtn);
        menuContainer.addChild(statusLabel);
        addChild(menuContainer);
    }

    private function onSignInClick(event:TouchEvent):void {
        event.stopPropagation();
        var touch:Touch = event.getTouch(signInBtn, TouchPhase.ENDED);
        if (touch && touch.phase == TouchPhase.ENDED) {
            appleSignIn.signIn(new <String>[AuthorizationScope.email, AuthorizationScope.fullName]);
        }
    }

    private function onGetCredentialStateClick(event:TouchEvent):void {
        event.stopPropagation();
        var touch:Touch = event.getTouch(getCredentialStateBtn, TouchPhase.ENDED);
        if (touch && touch.phase == TouchPhase.ENDED) {
            appleSignIn.getCredentialState("x.x.x",
                    function (state:int, error:Error = null):void {
                        if (error) {
                            statusLabel.text = "Credential Error: " + error.message + "\nReason: ";
                            switch (error.errorID) {
                                case AuthorizationErrorCode.unknown:
                                    statusLabel.text += "Unknown";
                                    break;
                                case AuthorizationErrorCode.canceled:
                                    statusLabel.text += "Cancelled";
                                    break;
                                case AuthorizationErrorCode.failed:
                                    statusLabel.text += "Failed";
                                    break;
                                case AuthorizationErrorCode.invalidResponse:
                                    statusLabel.text += "Invalid Response";
                                    break;
                                case AuthorizationErrorCode.notHandled:
                                    statusLabel.text += "Not handled";
                                    break;
                            }
                            return;
                        }
                        switch (state) {
                            case AppleIDProviderCredentialState.authorized:
                                statusLabel.text = "Credential: Authorized";
                                break;
                            case AppleIDProviderCredentialState.notFound:
                                statusLabel.text = "Credential: Not Found";
                                break;
                            case AppleIDProviderCredentialState.revoked:
                                statusLabel.text = "Credential: Revoked";
                                break;
                        }
                    });
        }
    }

    private function onSuccess(event:AppleSignInEvent):void {
        var appleIDCredential:AppleIDCredential = event.appleIDCredential;
        trace(appleIDCredential.user);
        statusLabel.text = "";
        statusLabel.text += "User: " + appleIDCredential.user + "\n";
        statusLabel.text += "Fullname: " + appleIDCredential.fullName.givenName + " " + appleIDCredential.fullName.familyName + "\n";
        statusLabel.text += "Email: " + appleIDCredential.email + "\n";
        var realUserStatus:String;
        switch (appleIDCredential.realUserStatus) {
            case UserDetectionStatus.unknown:
                realUserStatus = "Unknown";
                break;
            case UserDetectionStatus.likelyReal:
                realUserStatus = "Likely Real";
                break;
            case UserDetectionStatus.unsupported:
                realUserStatus = "Unsupported";
                break;
        }
        statusLabel.text += "realUserStatus: " + realUserStatus + "\n";
        statusLabel.text += "Authorization Code: " + appleIDCredential.authorizationCode + "\n";
    }

    private function onError(event:AppleSignInErrorEvent):void {
        statusLabel.text = "Sign In Error: ";
        switch (event.error.errorID) {
            case AuthorizationErrorCode.unknown:
                statusLabel.text += "Unknown";
                break;
            case AuthorizationErrorCode.canceled:
                statusLabel.text += "Cancelled";
                break;
            case AuthorizationErrorCode.failed:
                statusLabel.text += "Failed";
                break;
            case AuthorizationErrorCode.invalidResponse:
                statusLabel.text += "Invalid Response";
                break;
            case AuthorizationErrorCode.notHandled:
                statusLabel.text += "Not handled";
                break;
        }
        statusLabel.text += "\n" + event.error.message;
    }

    private function onExiting(event:Event):void {
        AppleSignInANE.dispose();
    }


}
}