@Observed
export class MenuEntity {
  menuIcon: ResourceStr
  menuName: string
  isChecked: boolean

  constructor(menuIcon: ResourceStr, menuName: string) {
    this.menuIcon = menuIcon
    this.menuName = menuName
    this.isChecked = false
  }
}

export class MenuGroupEntity {
  groupName: string
  menuList: MenuEntity[]

  constructor(groupName: string, menuList: MenuEntity[]) {
    this.groupName = groupName
    this.menuList = menuList
  }
}