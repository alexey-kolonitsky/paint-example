/**
 * Created with IntelliJ IDEA.
 * User: admin
 * Date: 09.01.14
 * Time: 12:52
 * To change this template use File | Settings | File Templates.
 */
package app.appMvc.controller {
import app.appMvc.Notes;
import app.appMvc.model.appManager.AppManagerProxy;
import app.appMvc.model.applicationSettings.ApplicationSettingsProxy;
import app.appMvc.model.appManager.AppManagerMediator;
import app.appMvc.view.StageMediator;
import app.appMvc.view.toolbar.ToolbarMediator;

import flash.display.Stage;

import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

public class StartupCommand extends SimpleCommand {
    override public function execute(note:INotification):void {
        var stage:Stage = note.getBody() as Stage;

        // insert registerCommand()s here
        facade.registerCommand(Notes.SET_TOOL_COMMAND,SetToolCommand);

        // insert registerProxy()s here
        facade.registerProxy(new ApplicationSettingsProxy());
        facade.registerProxy(new AppManagerProxy(stage));

        // insert registerMediator()s here
        facade.registerMediator(new StageMediator(stage));
        facade.registerMediator(new AppManagerMediator());
        facade.registerMediator(new ToolbarMediator(stage));

        // insert post actions here
        // ...

        trace("executed StartupCommand");
    }
}
}
