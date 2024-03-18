import { NormalButton } from '@ohos/components/Index'
import { FloatManagerPage } from '@ohos/floatwindow/Index'
import { Log } from '@ohos/utils/Index'
import { Constants, RouterConstants } from '../model/Constants'
import { HomeMenuEntity } from '../model/HomeMenuEntity'
import { EntryVM } from '../vm/EntryVM'

@Entry
@Component
struct Index {
  @State entryVM: EntryVM = new EntryVM()
  @Provide("pathStack") appPathStack: NavPathStack = new NavPathStack()

  aboutToAppear(): void {

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
                this.appPathStack.pushPath({ name: item.routerName })
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
    if (name === RouterConstants.FLOAT_MANAGER) {
      FloatManagerPage({
        onBack: () => {
          this.appPathStack.pop()
        }
      })
    }
  }
}