import { common } from '@kit.AbilityKit'
import { Log } from '@ohos/utils/Index'
import FloatManager from '../float/FloatManager'
import { FloatEventHubConstants } from '../model/Constants'

@Entry({routeName: "floatPage"})
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
            }
          })
          .onActionEnd(() => {
            Log.info(`PanGesture onActionEnd`)
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