/**
 * Description: 路由管理
 * Author: luyao
 * Date: 2024/3/19 17:17
 */

export class NavigationManager {
  private static instance: NavigationManager
  private appNavPathStack: NavPathStack | null = null

  private constructor() {
  }

  public static getInstance(): NavigationManager {
    if (!NavigationManager.instance) {
      NavigationManager.instance = new NavigationManager()
    }
    return NavigationManager.instance
  }

  setAppNavPathStack(navPathStack: NavPathStack) {
    this.appNavPathStack = navPathStack
  }

  pushPathByName(name: string, param?: object, animated?: boolean) {
    if (this.appNavPathStack) {
      this.appNavPathStack.pushPathByName(name, param, animated)
    }
  }

  clear() {
    if (this.appNavPathStack) {
      this.appNavPathStack.clear()
    }
  }

  pop() {
    if (this.appNavPathStack) {
      this.appNavPathStack.pop()
    }
  }
}