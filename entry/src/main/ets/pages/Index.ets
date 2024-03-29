import { FloatManagerPage } from '@ohos/floatwindow/Index'
import { Constants, RouterConstants } from '../model/Constants'
import { HomeMenuEntity } from '../model/HomeMenuEntity'
import { NavigationManager } from '../../../../../common/utils/src/main/ets/utils/NavigationManager'
import { EntryVM } from '../vm/EntryVM'
import { HarHspPage } from './HarHspPage'
import { HspOnePage } from '@ohos/hspOne/Index'
import { HarOnePage } from '@ohos/harOne/Index'
import { HarTwoPage } from '@ohos/harTwo/Index'
import { HspTwoPage } from '@ohos/hspTwo/Index'
import { Log } from '@ohos/utils/Index'
import { NormalButton } from '@ohos/components/Index'

@Entry
@Component
struct Index {
  @State entryVM: EntryVM = new EntryVM()
  @Provide("pathStack") appPathStack: NavPathStack = new NavPathStack()
  onBack: () => void = () => {
    this.appPathStack.pop()
  }

  aboutToAppear(): void {
    NavigationManager.getInstance().setAppNavPathStack(this.appPathStack)
  }

  build() {
    Navigation(this.appPathStack) {
      List() {
        ForEach(this.entryVM.homeMenuList, (item: HomeMenuEntity) => {
          ListItem() {
            NormalButton({
              text: item.name,
              click: () => {
                Log.error("click menu")
                this.appPathStack.pushPathByName(item.routerName, null)
              }
            })
          }
        }, (item: HomeMenuEntity) => item.routerName)
      }
      .width('100%')
      .height('100%')
    }
    .padding({ top: px2vp(Constants.topPadding) + 8 })
    .hideTitleBar(true)
    .mode(NavigationMode.Auto)
    .navDestination(this.appRouter)
  }

  @Builder
  appRouter(name: string, param: object) {
    NavDestination() {
      if (name === RouterConstants.FLOAT_MANAGER) {
        FloatManagerPage()
      } else if (name === RouterConstants.HAR_HSP) {
        HarHspPage()
      } else if (name == "HarOnePage") {
        HarOnePage()
      } else if (name == "HarTwoPage") {
        HarTwoPage()
      } else if (name === "HspOnePage") {
        HspOnePage()
      } else if (name === "HspTwoPage") {
        HspTwoPage()
      }
    }.hideTitleBar(true)
  }
}