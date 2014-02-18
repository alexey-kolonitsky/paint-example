/**
 * Created with IntelliJ IDEA.
 * User: admin
 * Date: 14.01.14
 * Time: 12:13
 * To change this template use File | Settings | File Templates.
 */
package app.appMvc.model.tool {
import flash.display.Graphics;
import flash.events.MouseEvent;

public class ToolStencilBrush extends Tool {
    public static const NAME:String = "ToolStencilBrush";
    public function ToolStencilBrush() {
        super(NAME);
    }

    override public function handleMouseDown(e:MouseEvent):void {
        e.target.dispatchEvent(new ToolSettingsEvent(ToolSettingsEvent.UPDATE_ACTIVE_LAYER,true));

        if(!activeLayer) {
            trace("No active layer");
            e.target.dispatchEvent(new ToolSettingsEvent(ToolSettingsEvent.NULL_ACTIVE_LAYER,true));
            return;
        }

        _isInUse = true;
    }

    override public function handleMouseUp(e:MouseEvent):void {
        _isInUse = false;
    }

    override public function handleMouseMove(e:MouseEvent):void {
        if (_isInUse) {
            useTool(e);
        }
        function useTool(e:MouseEvent):void {
            activeLayer.graphics.beginFill(0x000000, 1.0);
            activeLayer.graphics.lineStyle();
            activeLayer.graphics.drawCircle(e.stageX, e.stageY, 5);
            activeLayer.graphics.endFill();
        }
    }
}
}
