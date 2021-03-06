/**
 * Created by cfe on 20.02.14.
 */
package app.appMvc.view.keyNotifier {
import app.S;
import app.appMvc.Notes;

import flash.events.KeyboardEvent;

import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * Sends flash keyboardEvents as pureMVC notifications
 */
public class KeyNotifierMediator extends Mediator{
    public static const NAME:String = "KeyNotifierMediator";
    public function KeyNotifierMediator() {
    }
    private function handleKeyDown(keyEvent:KeyboardEvent):void {sendNotification(Notes.KEY_DOWN, keyEvent);}
    private function handleKeyUp(keyEvent:KeyboardEvent):void {sendNotification(Notes.KEY_UP, keyEvent);}

    override public function onRegister():void {
        S.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
        S.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
    }

    override public function onRemove():void {
        S.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
        S.stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
    }
}
}
