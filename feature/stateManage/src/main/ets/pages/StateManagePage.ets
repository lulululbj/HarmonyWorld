import { TitleComponent } from '@ohos/components/Index'
import { NavigationManager } from '@ohos/utils/Index'

@Component
export struct StateManagePage {
  build() {
    Column() {
      TitleComponent({
        title: "状态管理",
        onBack: () => {
          NavigationManager.getInstance().pop()
        }
      })
    }
  }
}