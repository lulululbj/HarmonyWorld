export class HomeMenuEntity {
  name: string = ""
  routerName: string = ""

  constructor(name: string, routerName: string) {
    this.name = name
    this.routerName = routerName
  }
}