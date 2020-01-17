package {

import com.tuarua.AppleSignInANE;
import com.tuarua.FreSwift;
import com.tuarua.applesigninane.AppleIDProviderCredentialState;
import com.tuarua.applesigninane.AuthorizationErrorCode;
import com.tuarua.applesigninane.AuthorizationScope;
import com.tuarua.applesigninane.events.AppleSignInErrorEvent;
import com.tuarua.applesigninane.events.AppleSignInEvent;

import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.AntiAliasType;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

import views.SimpleButton;

[SWF(width="800", height="600", frameRate="60", backgroundColor="#FFFFFF")]
public class Main extends Sprite {
    private var freSwiftANE:FreSwift = new FreSwift(); // must create before all others
    private var appleSignIn:AppleSignInANE;
    public static const FONT:Font = new FiraSansSemiBold();
    private var statusLabel:TextField = new TextField();

    public function Main() {
        super();

        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        NativeApplication.nativeApplication.executeInBackground = true;
        NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);
        start();
    }

    private function start():void {
        var tf:TextFormat = new TextFormat(Main.FONT.fontName, 13, 0x222222);
        tf.align = "center";
        tf.bold = false;

        statusLabel = new TextField();
        statusLabel.wordWrap = statusLabel.multiline = false;
        statusLabel.embedFonts = true;
        statusLabel.antiAliasType = AntiAliasType.ADVANCED;
        statusLabel.sharpness = -100;
        statusLabel.defaultTextFormat = tf;
        statusLabel.selectable = false;
        statusLabel.width = stage.stageWidth;

        var signInBtn:SimpleButton = new SimpleButton("Sign In");
        signInBtn.addEventListener(MouseEvent.CLICK, onSignInClick);
        signInBtn.x = (stage.stageWidth - signInBtn.width) / 2;
        signInBtn.y = 80;

        var getCredentialStateBtn:SimpleButton = new SimpleButton("Get Credential State");
        getCredentialStateBtn.addEventListener(MouseEvent.CLICK, onGetCredentialStateClick);
        getCredentialStateBtn.x = (stage.stageWidth - getCredentialStateBtn.width) / 2;
        getCredentialStateBtn.y = signInBtn.y + 80;

        appleSignIn = AppleSignInANE.appleSignIn;
        if (appleSignIn.isSupported) {
            appleSignIn.addEventListener(AppleSignInErrorEvent.ERROR, onError);
            appleSignIn.addEventListener(AppleSignInEvent.SUCCESS, onSuccess);
            addChild(signInBtn);
            addChild(getCredentialStateBtn);
        } else {
            statusLabel.text = "Apple Sign In is only supported on MacOS 10.15+";
        }

        statusLabel.y = getCredentialStateBtn.y + 80;
        addChild(statusLabel);

    }

    private function onSignInClick(event:MouseEvent):void {
        appleSignIn.signIn(new <String>[AuthorizationScope.email, AuthorizationScope.fullName]);
    }

    private function onGetCredentialStateClick(event:MouseEvent):void {
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

    private function onSuccess(event:AppleSignInEvent):void {
        statusLabel.text = "Sign In Success: ";
        if (event.appleIDCredential) {
            statusLabel.text += "\nappleIDCredential.user: " + event.appleIDCredential.user;
        }
        if (event.passwordCredential) {
            statusLabel.text += "\npasswordCredential.user: " + event.passwordCredential.user;
        }
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
        freSwiftANE.dispose();
        AppleSignInANE.dispose();
    }
}
}
