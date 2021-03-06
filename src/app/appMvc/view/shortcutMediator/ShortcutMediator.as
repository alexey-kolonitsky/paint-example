package app.appMvc.view.shortcutMediator {
import app.appMvc.Notes;

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import org.puremvc.as3.interfaces.INotification;

import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * Sends notifications that other mediators listen to.
 */
public class ShortcutMediator extends Mediator {
    public static const NAME:String = "ShortcutMediator";
    public function ShortcutMediator() {super(NAME);}

    override public function listNotificationInterests():Array {
        return [
            Notes.KEY_DOWN,
            Notes.KEY_UP
        ]
    }

    override public function handleNotification(note:INotification):void {
        var keyEvent:KeyboardEvent = note.getBody() as KeyboardEvent;
        switch (note.getName()) {

            case Notes.KEY_DOWN:
                break;

            case Notes.KEY_UP:

                switch (keyEvent.keyCode) {
                    case Keyboard.ESCAPE:
                        break;
                    case Keyboard.T:
                        sendNotification(Notes.TOGGLE_TOOLBAR_VISIBILITY);
                        break;
                }
                break;
        }
    }
}
}
