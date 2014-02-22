package app.appMvc.view.mainWindow {
import app.S;
import app.appMvc.Notes;
import app.appMvc.model.applicationSettings.ApplicationSettingsProxy;

import flash.events.MouseEvent;

import org.puremvc.as3.interfaces.INotification;

import org.puremvc.as3.patterns.mediator.Mediator;

public class MainWindowMediator extends Mediator {
    public static const NAME:String = "MainWindowMediator";
    public function get mainWindow():MainWindow {return viewComponent as MainWindow;}
    public function MainWindowMediator() {
        super(NAME);
        var appSettingsProxy:ApplicationSettingsProxy = facade.retrieveProxy(ApplicationSettingsProxy.NAME) as ApplicationSettingsProxy;
        setViewComponent(new MainWindow(appSettingsProxy.settings.activeDocument));
    }

    override public function listNotificationInterests():Array {
        return [
            Notes.PUSH_SHIFT_DOC_COORDINATES_COMMAND
        ]
    }

    override public function handleNotification(note:INotification):void {
        switch (note.getName()) {
            case Notes.PUSH_SHIFT_DOC_COORDINATES_COMMAND:
                mainWindow.updateDocumentBack();
                break;
        }
    }
    override public function onRegister():void {
        S.stage.addChildAt(mainWindow, 0);
        mainWindow.addListeners();

        S.stage.addEventListener(MainWindowEvent.MOUSE_DOWN, handleMouseDown, false, 0, true);
        S.stage.addEventListener(MainWindowEvent.MOUSE_MOVE, handleMouseMove, false, 0, true);
        S.stage.addEventListener(MainWindowEvent.MOUSE_UP, handleMouseUp, false, 0, true);
    }
    override public function onRemove():void {
        S.stage.removeChild(mainWindow);
        mainWindow.removeListeners();

        S.stage.removeEventListener(MainWindowEvent.MOUSE_DOWN, handleMouseDown);
        S.stage.removeEventListener(MainWindowEvent.MOUSE_MOVE, handleMouseMove);
        S.stage.removeEventListener(MainWindowEvent.MOUSE_UP, handleMouseUp);
    }

    private function handleMouseDown(e:MainWindowEvent):void {
        sendNotification(Notes.MAIN_WINDOW_MOUSE_DOWN, e);
        sendNotification(Notes.MAIN_WINDOW_DOC_MOUSE_DOWN, relativeDocMouseEvent(e));
    }

    private function handleMouseMove(e:MainWindowEvent):void {
        sendNotification(Notes.MAIN_WINDOW_MOUSE_MOVE, e);
        sendNotification(Notes.MAIN_WINDOW_DOC_MOUSE_MOVE, relativeDocMouseEvent(e));
    }

    private function handleMouseUp(e:MainWindowEvent):void {
        sendNotification(Notes.MAIN_WINDOW_MOUSE_UP, e);
        var mE:MouseEvent = e.data as MouseEvent;
        sendNotification(Notes.MAIN_WINDOW_DOC_MOUSE_UP, {
            mouseEvent: relativeDocMouseEvent(e),
            relX:mE.stageX - mainWindow.shiftDocX,
            relY:mE.stageY - mainWindow.shiftDocY
        });
    }

    private function relativeDocMouseEvent(e:MainWindowEvent):MouseEvent {
        var mE:MouseEvent = e.data as MouseEvent;
        mE.localX = mE.stageX - mainWindow.shiftDocX;
        mE.localY = mE.stageY - mainWindow.shiftDocY;
//        var relDocMouseEvent:MouseEvent = new MouseEvent(mE.type, mE.bubbles, mE.cancelable,
//                                                      mE.localX = mE.stageX - mainWindow.shiftDocX,
//                                                      mE.localY = mE.stageY - mainWindow.shiftDocY,
//                                                      mE.relatedObject, mE.ctrlKey, mE.altKey,
//                                                      mE.shiftKey, mE.buttonDown, mE.delta);
        return mE;// relDocMouseEvent;
    }
}
}
