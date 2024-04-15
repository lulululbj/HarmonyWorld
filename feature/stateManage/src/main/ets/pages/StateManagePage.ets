import { TitleComponent } from '@ohos/components/Index'
import { NavigationManager } from '@ohos/utils/Index'
import { MenuEntity } from '../entity/MenuEntity'
import { StateManageVM } from '../vm/StateManageVM'
import { GroupMenuComponent } from './GroupMenuComponent'
import { MyMenuComponent } from './MyMenuComponent'
import { MyMenuEditComponent } from './MyMenuEditComponent'

@Component
export struct StateManagePage {
  @State vm: StateManageVM = new StateManageVM()

  aboutToAppear(): void {
    this.vm.getMenuGroupData()
  }

  build() {
    Column() {
      // 未编辑状态标题栏
      TitleComponent({
        title: "状态管理",
        leftClick: () => {
          NavigationManager.getInstance().pop()
        }
      })
        .visibility(this.vm.isEditing ? Visibility.None : Visibility.Visible)

      // 编辑状态标题栏
      TitleComponent({
        title: "管理应用",
        leftImageRes: null,
        leftText: "取消",
        rightText: "保存",
        leftClick: () => {
          this.vm.changeEditStatus()
        },
        rightClick: () => {
          this.vm.changeEditStatus()
        }
      })
        .visibility(this.vm.isEditing ? Visibility.Visible : Visibility.None)

      // 未编辑状态下首页应用
      MyMenuComponent({
        menuList: this.vm.myMenuData,
        changeEditStatus: () => {
          this.vm.changeEditStatus()
        }
      })
        .visibility(this.vm.isEditing ? Visibility.None : Visibility.Visible)

      Text("拖动可调整应用位置")
        .fontColor(Color.Gray)
        .fontSize(14)
        .alignSelf(ItemAlign.Center)
        .visibility(this.vm.isEditing ? Visibility.Visible : Visibility.None)
        .margin({top: 16})

      // 编辑状态下我的应用
      MyMenuEditComponent({
        menuList: this.vm.myMenuData,
        removeMenu: (menu: MenuEntity) => {
          this.vm.removeFromMyMenu(menu)
        }
      })
        .visibility(this.vm.isEditing ? Visibility.Visible : Visibility.None)

      // 分组全部菜单
      GroupMenuComponent({
        menuGroupData: this.vm.menuGroupData,
        isEditing: this.vm.isEditing,
        addMenu: (menu: MenuEntity) => {
          this.vm.addToMyMenu(menu)
        }
      })
    }
    .height('100%')
    .backgroundColor("#f5f5f5")
  }
}