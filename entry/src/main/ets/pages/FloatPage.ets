import { Log } from '@ohos/utils/Index'
import { common } from '@kit.AbilityKit'
import { FloatManager } from '@ohos/floatwindow'
import { FloatEventHubConstants } from '@ohos/floatwindow/src/main/ets/model/Constants'

@Entry
@Component
export struct FloatPage {
  private context = getContext(this) as common.UIAbilityContext

  build() {
    Column() {
      Image($r('app.media.mobile_dev'))
        .width('100%')
        .height('100%')
    }
    .gesture(
      GestureGroup(GestureMode.Exclusive,
        PanGesture()
          .onActionUpdate((event: GestureEvent | undefined) => {
            if (event) {
              Log.error(`offsetX: ${event.offsetX} offsetY: ${event.offsetY}`)
              FloatManager.updateLocation(event.offsetX, event.offsetY)
              FloatManager.saveLocation()
            }
          })
          .onActionEnd((event: GestureEvent | undefined) => {
              Log.error("onActionEnd")
              FloatManager.saveLocation()
          }),
        TapGesture({ count: 1 })
          .onAction(() => {
            this.context.eventHub.emit(FloatEventHubConstants.event_click_float)
          }))
    )
  }

  onBackPress(): boolean | void {
    this.context.eventHub.emit(FloatEventHubConstants.event_float_onback)
  }
}